/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * gwsCommand.c
 *
 * FUNCTION NAME(S)
 * initInit		- Initialization routine of INIT command
 * initSub		- Start the INIT command actions
 * initSetParameters	- Set initialization file name and pvload arguments
 * initTask		- Run pvload on initialization file
 * bootSub		- Processing routine of BOOT command
 * simMask		- Convert simulation level into a mask
 * wsMask		- Convert weather station number into a mask
 *
 *INDENT-OFF*
 * $Log: gwsCommands.c,v $
 * Revision 1.2  2003/10/23 17:45:05  pedro
 * Added SOAR weather station.
 *
 * Revision 1.1  2002/05/31 19:35:10  pedro
 * Installed V1-0 (first official CVS release).
 *
 *INDENT-ON*
 */

#include "gws.h"
#include <epicsEvent.h> 
#include <epicsThread.h>
#include <subRecord.h>
#include <epicsPrint.h>   
#include <epicsExport.h>
#include <registryFunction.h>
#include <iocsh.h> 

/*
 * Max number of characters in an initialization file name. It doesn't
 * need larger than the max number of characters in an EPICS string field.
 */
#define	SZ_FNAME	50

/*
 * Local variables.
 */
static	epicsEventId	initSemId  = NULL;	/* initialization semaphore id */
static char	initFileName[SZ_FNAME];	/* initialization file name */
static char	initPvArgs[SZ_FNAME];	/* pvload arguments */

/*
 * Function definitions
 */
extern int	pvload (char *, char *, int, int);
epicsThreadId initTaskId = 0;

/*
 *+
 * FUNCTION NAME:
 * initTask
 *
 * INVOCATION:
 * taskSpawn ("gwsInitTask", 90, VX_FP_TASK, 0x1000, initTask, ...)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * None
 * 
 * FUNCTION VALUE:
 * (int)       never returns
 *
 * PURPOSE:
 * Run pvload on initialization file
 *
 * DESCRIPTION:
 * This routine is spawned as a task when the sub record in charge of the
 * INIT command is initialized. The purpose of this task is to wait for
 * a semaphore and run pvload on the initialization file.
 *
 * EPICS INPUT FIELDS:
 * None
 *
 * EPICS OUTPUT FIELDS:
 * None
 *
 * EXTERNAL VARIABLES:
 * initSemId
 * initFileName
 * initPvArgs
 *
 * PRIOR REQUIREMENTS:
 * initFileName and initPvArgs should be initialized before giving the
 * semaphore for the first time. This is done calling initSetParameters
 * from the vxWorks level.
 *
 * DEFICIENCIES:
 * None
 *-
 */
void initTask(void *p) {

	while (TRUE) {
	    epicsEventMustWait(initSemId);
 	    errlogPrintf ("initTask: filename:%s args:%s\n",initFileName,initPvArgs);
	    if (strlen (initFileName) > 0 && strlen (initPvArgs) > 0) {
		errlogPrintf ("initTask: running pvload fname=(%s), args=(%s)\n",
			initFileName,  initPvArgs);
	    	pvload (initFileName, initPvArgs, 4, 1);
	    } else {
		errlogPrintf ("initTask: empty file name and/or pvload args");
	    }
	}

	return;
}
/*
 *+
 * FUNCTION NAME:
 * initInit
 *
 * INVOCATION:
 * initInit (psub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) name (struct subRecord *)	sub record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always zero
 *
 * PURPOSE:
 * Initialization routine of INIT command
 *
 * DESCRIPTION:
 * This routine spawns a task that will be in charge of running pvload
 * every time the INIT command is executed. I also creates a semaphore
 * that will be used to tell the task when to run pvload.
 *
 * EPICS INPUT FIELDS:
 * (long) A	debug level
 *
 * EPICS OUTPUT FIELDS:
 * None
 *
 * EXTERNAL VARIABLES:
 * initSemId
 * initTaskId
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
long initInit (struct subRecord *psub)
{
	int	debug;

	/*
	 * Get input links.
	 */
	debug = psub->a;

	if (DEBUG_MIN)
	    errlogPrintf ("initInit: debug=%d\n", debug);

	/*
	 * Create semaphore used to make the initialization task to process.
	 */
	initSemId = epicsEventMustCreate(epicsEventEmpty);
	if (initSemId == NULL) {
	    errlogPrintf ("initInit: Cannot create initialization semaphore\n");
	}
	errlogPrintf ("initInit: semaphore create semid=%p\n", initSemId);

	/*
	 * Spawn an initialization task.
	 */
        if (!initTaskId) {
            initTaskId = epicsThreadCreate("gwsInitTask", 
                               epicsThreadPriorityMedium,
                               epicsThreadGetStackSize(epicsThreadStackMedium),
                               initTask,
                               NULL);

        }
	if (!initTaskId) {
	    errlogPrintf ("initInit: Cannot spawn initialization thread\n");
	}

	errlogPrintf ("initInit: task spawned tid=%p\n", initTaskId);

	return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * initSub
 *
 * INVOCATION:
 * initSub (psub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psub (struct subRecord *)	pointer to sub record
 * 
 * FUNCTION VALUE:
 * (long)       always zero
 *
 * PURPOSE:
 * Start the INIT command actions
 *
 * DESCRIPTION:
 * This routine will make the initialization task to start running pvload
 * in order to reload default database values. The work is done by giving
 * the task semaphore to unblock the initialization task that's always
 * running.
 *
 * EPICS INPUT FIELDS:
 * (long)   A	debug level
 * (string) C	initialization file name
 * (string) E	pvload arguments
 *
 * EPICS OUTPUT FIELDS:
 * None
 *
 * EXTERNAL VARIABLES:
 * initSemId
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * There is no feedback on when the task finishes procession pvload, so
 * the initC record should be set to IDLE from the initialization file.
 *-
 */
long initSub (struct subRecord *psub)
{
	int	debug;

	debug = psub->a;

	if (DEBUG_MIN)
	    errlogPrintf ("initSub: debug=%d\n", debug);

	/*
	 * Give semaphore.
	 */
	epicsEventSignal(initSemId);
/* 	if (epicsEventSignal(initSemId)) {
	    errlogPrintf ("initSub: Cannot trigger start initialization\n");
	}
 */
	return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * initSetParameters
 *
 * INVOCATION:
 * initSetParameters (fname, args)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) fname (char *)	initializaton file name
 * (>) args (char *)	pvload arguments
 * 
 * FUNCTION VALUE:
 * (int)       always zero
 *
 * PURPOSE:
 * Set initialization file name and database pvload arguments
 *
 * DESCRIPTION:
 * This routine is used to initialize the initialization file name
 * and database pvload arguments from RTEMS shell.
 *
 * EPICS INPUT FIELDS:
 * None
 *
 * EPICS OUTPUT FIELDS:
 * None
 *
 * EXTERNAL VARIABLES:
 * initFileName
 * initPvArgs
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
int initSetParameters (char *fname, char *args)
{
	strncpy (initPvArgs, args, SZ_FNAME - 1);
	initPvArgs[SZ_FNAME - 1] = '\0';

	strncpy (initFileName, fname, SZ_FNAME - 1);
	initFileName[SZ_FNAME - 1] = '\0';

	return (0);
}



/*
 *+
 * FUNCTION NAME:
 * bootSub name
 *
 * INVOCATION:
 * bootSub (psub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psub (struct subRecord *)	sub record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always zero
 *
 * PURPOSE:
 * Processing routine of BOOT command
 *
 * DESCRIPTION:
 * This routine reboots the IOC by calling reboot().
 *
 * EPICS INPUT FIELDS:
 * (long) A	debug level
 *
 * EPICS OUTPUT FIELDS:
 * None
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
long bootSub (struct subRecord *psub)
{
	int	debug;

	debug = psub->a;

	if (DEBUG_MIN)
	    errlogPrintf ("bootSub: debug=%d\n", debug);

/*	reboot (BOOT_CLEAR); */

	return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * simMask
 *
 * INVOCATION:
 * simMask (psub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psub (struct subRecord *)	sub record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always zero
 *
 * PURPOSE:
 * Convert simulation level into a mask
 *
 * DESCRIPTION:
 * This routine converts a simulation level into a simulation mask used
 * by fanout record to fire different parts of the code depending on the
 * simulation level. The level v/s mask equivalence is as follows:
 *
 *     Level    Mask   Link1  Link2  Link3  Link4
 *    --------------------------------------------
 *     NONE      1       1      0      0      0
 *     VSM       2       0      1      0      0
 *     FAST      4       0      0      1      0
 *     FULL      8       0      0      0      1
 *
 * EPICS INPUT FIELDS:
 * (long) A	simulation level
 * (long) N	debug level
 *
 * EPICS OUTPUT FIELDS:
 * (LONG) VAL	simulation mask
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
long simMask (struct subRecord *psub)
{
	int	debug, sim;

	/*
	 * Get input links.
	 */
	sim   = psub->a;
	debug = psub->b;

	if (DEBUG_MIN)
	    errlogPrintf ("simMask: debug=%d\n", debug);

	/*
	 * Brach on simulation level.
	 */
	switch (sim) {
	case SIMM_NONE:
	    psub->val = 1;
	    break; 

	case SIMM_VSM:
	    psub->val = 2;
	    break; 

	case SIMM_FAST:
	    psub->val = 4;
	    break; 

	case SIMM_FULL:
	    psub->val = 8;
	    break; 

	default:
	    errlogPrintf ("simMask: Unknown simulation level %d", sim);
	    psub->val = 1;	/* default to NONE */
	}

	if (DEBUG_FULL) {
	    errlogPrintf ("simMask: simulation mask set to %d\n",
		      (int) psub->val);
	}

	return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * wsMask
 *
 * INVOCATION:
 * wsMask (psub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psub (struct subRecord *)	sub record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always zero
 *
 * PURPOSE:
 * Convert weather station number into a mask
 *
 * DESCRIPTION:
 * This routine converts a weather station number into a weather station
 * mask used by ...
 *
 *     Level    Mask   Link1  Link2  Link3  Link4  Link5
 *    ---------------------------------------------------
 *     PACHON    1       1      0      0      0      0
 *     SOAR      2       0      1      0      0      0
 *     CTIO      3       0      0      1      0      0
 *     CFHT      4       0      0      0      1      0
 *     UKIRT     5       0      0      0      0      1
 *
 * EPICS INPUT FIELDS:
 * (long) A	simulation level
 * (long) N	debug level
 *
 * EPICS OUTPUT FIELDS:
 * (LONG) VAL	simulation mask
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
long wsMask (struct subRecord *psub)
{
	int	debug, sim;

	/*
	 * Get input links.
	 */
	sim   = psub->a;
	debug = psub->b;

	if (DEBUG_MIN)
	    errlogPrintf ("wsMask: debug=%d\n", debug);

	/*
	 * Brach on simulation level.
	 */
	switch (sim) {
	case WS_PACHON:
	    psub->val = 1;
	    break; 

	case WS_SOAR:
	    psub->val = 2;
	    break; 

	case WS_CTIO:
	    psub->val = 4;
	    break; 

	case WS_CFHT:
	    psub->val = 8;
	    break; 

	case WS_UKIRT:
	    psub->val = 16;
	    break; 

	default:
	    errlogPrintf ("simMask: Unknown weather station number %d",
		    sim);
	    psub->val = 0;	/* default to none */
	}

	if (DEBUG_FULL) {
	    errlogPrintf ("wsMask: weather station mask set to %d\n",
		      (int) psub->val);
	}

	return (0L);
}


static const iocshArg initSetParametersArg0 = {"filename", iocshArgString };
static const iocshArg initSetParametersArg1 = {"args", iocshArgString };
static const iocshArg *initSetParametersArgs[] = {
                &initSetParametersArg0,
                &initSetParametersArg1 };
static const iocshFuncDef initSetParametersFuncDef = 
             {"initSetParameters", 2, initSetParametersArgs };
static void initSetParametersCallFunc(const iocshArgBuf *args)
{
   initSetParameters(args[0].sval, args[1].sval);
}


static void gwsRegisterCommands(void)
{
   static int firstTime = 1;
   if(firstTime) {
      iocshRegister(&initSetParametersFuncDef, initSetParametersCallFunc);
      firstTime = 0;
   }
}
epicsExportRegistrar(gwsRegisterCommands);









epicsRegisterFunction(bootSub);
epicsRegisterFunction(initSub);
epicsRegisterFunction(simMask);
epicsRegisterFunction(wsMask);
epicsRegisterFunction(initInit);
epicsRegisterFunction(initSetParameters);
