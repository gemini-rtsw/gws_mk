/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * gwsCad.c
 *
 * DESCRIPTION
 * CAD subroutines
 *
 * FUNCTION NAME(S)
 * name		- description
 *
 *INDENT-OFF*
 * $Log: gwsCad.c,v $
 * Revision 1.6  2005/09/06 18:11:25  pedro
 * Merged weather station task & routine debug modes and added debug modes
 * for DIMM, MASS and IRMA.
 *
 * Revision 1.5  2005/02/11 06:44:12  pedro
 * Added metSetupCad routine and added more debug modes in debugCad
 *
 * Revision 1.4  2005/02/01 03:47:32  pedro
 * Added environmental sensors
 *
 * Revision 1.3  2004/07/23 15:44:36  pedro
 * Added code for seeing debug mode.
 *
 * Revision 1.2  2003/10/23 17:45:05  pedro
 * Added SOAR weather station.
 *
 * Revision 1.1  2002/05/31 19:35:10  pedro
 * Installed V1-0 (first official CVS release).
 *
 *INDENT-ON*
 */

#include "gws.h"
#include "scan.h"

#include <cadRecord.h>
#include <cad.h>
#include    <epicsPrint.h>   
#include <epicsExport.h>
#include <registryFunction.h>
#include <iocsh.h> 

/*
 * Debug mode indices. They are used to index the array of debug modes
 * in debugCad. Should be zero indexed. The values are not important as
 * long as there are no "holes" in between.
 */
#define M_GENMODE	0	/* general */
#define M_CFHT		1	/* CFHT weather station */
#define M_PACHON	2	/* PACHON weather station */
#define M_CTIO		3	/* CTIO weather station */
#define M_SOAR		4	/* SOAR weather station */
#define M_UKIRT		5	/* UKIRT weather station */
#define M_DIMM		6	/* DIMM seeing monitor */
#define M_MASS		7	/* MASS seeing monitor */
#define M_IRMA		8	/* IRMA water vapor monitor */
#define M_TS		9	/* Ultrasonic anemometer */
#define M_UA		10	/* Ultrasonic anemometer */
#define M_HS		11	/* Humidity sensor */
#define M_PM		12	/* Particle monitor */
#define	MAX_MODES	13	/* Max number of debug modes */

/*
 *+
 * FUNCTION NAME:
 * debugCad
 *
 * INVOCATION:
 * debugCad (pcad)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (!) pcad (struct cadRecord *pcad)	CAD record pointer
 * 
 * FUNCTION VALUE:
 * (long)       CAD_ACCEPTED	valid debug level
 *		CAD_REJECTED	invalid debug level or cad directive
 *
 * PURPOSE:
 * Set the debug level
 *
 * DESCRIPTION:
 * This routine is associated with the debug CAD record. It checks the
 * debug level argument and writes the validated debug level to an
 * output field.
 *
 * EPICS INPUT FIELDS:
 * (char *)	A	debug mode (general)
 * (char *)	B	debug mode for CFHT web station task
 * (char *)	C	debug mode for PACHON web station
 * (char *)	D	debug mode for CTIO web station task
 * (char *)	E	debug mode for SOAR web station task
 * (char *)	F	debug mode for UKIRT web station task
 * (char *)	G	debug mode for dimm seeing monitor
 * (char *)	H	debug mode for mass seeing monitor
 * (char *)	I	debug mode for irma water vapor monitor
 * (char *)	J	debug mode for temperature sensors
 * (char *)	K	debug mode for ultrasonic anemometers
 * (char *)	L	debug mode for humidity sensors
 * (char *)	M	debug mode for particle monitor
 * (long)	T	current debug level
 *
 * EPICS OUTPUT FIELDS:
 * (long)	VALA	debug level (general)
 * (long)	VALB	debug level for CFHT web station
 * (long)	VALC	debug level for PACHON web station
 * (long)	VALD	debug level for CTIO web station
 * (long)	VALE	debug level for SOAR web station
 * (long)	VALF	debug level for UKIRT web station
 * (long)	VALG	debug level for dimm seeing monitor
 * (long)	VALH	debug level for dimm mass seeing monitor
 * (long)	VALI	debug level for irma water vapor monitor
 * (long)	VALJ	debug level for temperature sensors
 * (long)	VALK	debug level for ultrasonic anemometers
 * (long)	VALL	debug level for humidity sensors
 * (long)	VALM	debug level for particle monitor
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
long debugCad (struct cadRecord *pcad)
{
	int		nmode, debug;
	long		dlevel, status;
	static char	*debugMenu[] = {"NONE", "MIN", "FULL", NULL};
	char		*mode[MAX_MODES];

	/*
	 * Get current debug level. Assume DBG_NONE if the value is
	 * not a valid number.
	 */
	if (scanInt (pcad->t, &debug) == 0)
	    debug = DBG_NONE;

	if (DEBUG_MIN) {
	    errlogPrintf ("debugCad: a=(%s), t=(%s), debug=%d\n",
		      pcad->a, pcad->t, (int) debug);
	}

	/*
	 * Get debug modes into array.
	 */
	mode[M_GENMODE] = pcad->a;
	mode[M_CFHT]    = pcad->b;
	mode[M_PACHON]  = pcad->c;
	mode[M_CTIO]    = pcad->d;
	mode[M_SOAR]    = pcad->e;
	mode[M_UKIRT]   = pcad->f;
	mode[M_DIMM]    = pcad->g;
	mode[M_MASS]    = pcad->h;
	mode[M_IRMA]    = pcad->i;
	mode[M_TS]      = pcad->j;
	mode[M_UA]      = pcad->k;
	mode[M_HS]      = pcad->l;
	mode[M_PM]      = pcad->m;

	/*
	 * Branch on CAD directive
	 */
	switch (pcad->dir) {
	case menuDirectiveMARK:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveCLEAR:
	    strcpy (pcad->a, "");
	    strcpy (pcad->b, "");
	    strcpy (pcad->c, "");
	    strcpy (pcad->d, "");
	    strcpy (pcad->e, "");
	    strcpy (pcad->f, "");
	    strcpy (pcad->g, "");
	    strcpy (pcad->h, "");
	    strcpy (pcad->i, "");
	    strcpy (pcad->j, "");
	    strcpy (pcad->k, "");
	    strcpy (pcad->l, "");
	    strcpy (pcad->m, "");
	    strcpy (pcad->n, "");
	    strcpy (pcad->o, "");
	    strcpy (pcad->p, "");
	    strcpy (pcad->q, "");
	    strcpy (pcad->r, "");
	    strcpy (pcad->s, "");
	    db_post_events (pcad, &pcad->a, 1);
	    db_post_events (pcad, &pcad->b, 1);
	    db_post_events (pcad, &pcad->c, 1);
	    db_post_events (pcad, &pcad->d, 1);
	    db_post_events (pcad, &pcad->e, 1);
	    db_post_events (pcad, &pcad->f, 1);
	    db_post_events (pcad, &pcad->g, 1);
	    db_post_events (pcad, &pcad->h, 1);
	    db_post_events (pcad, &pcad->i, 1);
	    db_post_events (pcad, &pcad->j, 1);
	    db_post_events (pcad, &pcad->k, 1);
	    db_post_events (pcad, &pcad->l, 1);
	    db_post_events (pcad, &pcad->m, 1);
	    db_post_events (pcad, &pcad->n, 1);
	    db_post_events (pcad, &pcad->o, 1);
	    db_post_events (pcad, &pcad->p, 1);
	    db_post_events (pcad, &pcad->q, 1);
	    db_post_events (pcad, &pcad->r, 1);
	    db_post_events (pcad, &pcad->s, 1);
	    status = CAD_ACCEPT;
	    break;

	case menuDirectivePRESET:

	    for (nmode = 0; nmode < MAX_MODES; nmode++) {

		/*
		 * Look for the debug mode in the debug menu. The debug
		 * level is the index of the mode in the array.
		 */
		dlevel = scanMenu (debugMenu, mode[nmode]);

		if (DEBUG_FULL)
		    errlogPrintf ("debugCad: dlevel=%ld\n", dlevel);

		/*
		 * If a match is found then write the debug level to the
		 * corresponding output link and accept the command.
		 * Otherwise reject the command.
		 */
		if (dlevel >= 0) {

		    if (DEBUG_FULL) {
			errlogPrintf ("debugCad: ACCEPTED dlevel = %d\n",
				  (int) dlevel);
		    }

		    switch (nmode) {
		    case M_GENMODE:
		        *(long *) pcad->vala = dlevel;
			break;
		    case M_CFHT:
		        *(long *) pcad->valb = dlevel;
			break;
		    case M_PACHON:
		        *(long *) pcad->valc = dlevel;
			break;
		    case M_CTIO:
		        *(long *) pcad->vald = dlevel;
			break;
		    case M_SOAR:
		        *(long *) pcad->vale = dlevel;
			break;
		    case M_UKIRT:
		        *(long *) pcad->valf = dlevel;
			break;
		    case M_DIMM:
		        *(long *) pcad->valg = dlevel;
			break;
		    case M_MASS:
		        *(long *) pcad->valh = dlevel;
			break;
		    case M_IRMA:
		        *(long *) pcad->vali = dlevel;
			break;
		    case M_TS:
		        *(long *) pcad->valj = dlevel;
			break;
		    case M_UA:
		        *(long *) pcad->valk = dlevel;
			break;
		    case M_HS:
		        *(long *) pcad->vall = dlevel;
			break;
		    case M_PM:
		        *(long *) pcad->valm = dlevel;
			break;
		    default:
			errlogPrintf ("debugCad: invalid mode number %d\n",
				nmode);
		    }
		    strcpy (pcad->mess, "");
		    status = CAD_ACCEPT;

		} else {
		    sprintf (pcad->mess,
			     "Argument must be NONE, MIN, or FULL\n");
		    status = CAD_REJECT;
		    break;
		}
	    }

	    /*
	     * Update the web service debug levels.
	     */
	    if (status == CAD_ACCEPT) {
/*		wsSetDebug  ("cfht",  (int) *(long *) pcad->valb);
		wsSetDebug  ("ctio",  (int) *(long *) pcad->valc);
		wsSetDebug  ("soar",  (int) *(long *) pcad->vald);
		wsSetDebug  ("ukirt", (int) *(long *) pcad->vale);
		webSetDebug ("dimm",  (int) *(long *) pcad->valk);
		webSetDebug ("mass",  (int) *(long *) pcad->valk);
		webSetDebug ("irma",  (int) *(long *) pcad->valk); */
	    }

	    break;

	case menuDirectiveSTART:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTOP:
	    status = CAD_ACCEPT;
	    break;

	default:
	    errlogPrintf ("debugCad: Invalid CAD directive\n");
	    status = CAD_REJECT;
	}

	return (status);
}

/*
 *+
 * FUNCTION NAME:
 * simCad
 *
 * INVOCATION:
 * simCad (pcad)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (!) pcad (struct cadRecord *pcad)	CAD record pointer
 * 
 * FUNCTION VALUE:
 * (long)       CAD_ACCEPTED	valid simulation level
 *		CAD_REJECTED	invalid simulation level
 *
 * PURPOSE:
 * Set the simulation level
 *
 * DESCRIPTION:
 * This routine is associated with the simulation CAD record. It checks the
 * simulation level argument and writes the validated simulation level to an
 * output field.
 *
 * EPICS INPUT FIELDS:
 * (char *)	A	requested simulation level
 * (char *)	B	current debug level
 *
 * EPICS OUTPUT FIELDS:
 * (long)	VALA	validated simulation level
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
long simCad (struct cadRecord *pcad)
{
	int		debug;
	long		slevel, status;
	static char	*simMenu[] =
				{"NONE", "VSM", "FAST", "FULL", NULL};

	/*
	 * Get current debug level. Assume DBG_NONE if the value is
	 * not a valid number.
	 */
	if (scanInt (pcad->b, &debug) == 0)
	    debug = DBG_NONE;

	if (DEBUG_MIN) {
	    errlogPrintf ("simCad: a=(%s), b=(%s), debug=%d\n",
		      pcad->a, pcad->b, (int) debug);
	}

	/*
	 * Branch on CAD directive
	 */
	switch (pcad->dir) {
	case menuDirectiveMARK:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveCLEAR:
	    strcpy (pcad->a, "");
	    db_post_events (pcad, &pcad->a, 1);
	    status = CAD_ACCEPT;
	    break;

	case menuDirectivePRESET:

	    /*
	     * Look for the simulation mode in the simulation menu. The
	     * simulation level is the index of the mode in the array.
	     */
	    slevel = scanMenu (simMenu, pcad->a);

	    if (DEBUG_FULL)
		errlogPrintf ("simCad: slevel=%ld\n", slevel);

	    /*
	     * If a match is found then write the simulation level to the
	     * corresponding output link and accept the command. Otherwise
	     * reject the command.
	     */
	    if (slevel >= 0) {
		if (DEBUG_FULL) {
		    errlogPrintf ("simCad: ACCEPTED slevel = %d\n",
			      (int) slevel);
		}
		*(long *) pcad->vala = slevel;
		strcpy (pcad->mess, "");
		status = CAD_ACCEPT;
	    }
	    else {
		sprintf (pcad->mess,
			 "Argument must be NONE, VSM, FAST, FULL");
		status = CAD_REJECT;
	    }
	    break;

	case menuDirectiveSTART:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTOP:
	    status = CAD_ACCEPT;
	    break;

	default:
	    errlogPrintf ("simCad: Invalid CAD directive\n");
	    status = CAD_REJECT;
	}

	return (status);
}

/*
 *+
 * FUNCTION NAME:
 * initCad
 *
 * INVOCATION:
 * initCad (pcad)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (!) pcad (struct cadRecord *pcad)	CAD record pointer
 * 
 * FUNCTION VALUE:
 * (long)       CAD_ACCEPTED	valid simulation level
 *		CAD_REJECTED	invalid CAD directive
 *
 * PURPOSE:
 * Initialize the system
 *
 * DESCRIPTION:
 * This routine is associated with the init CAD record. It will trigger
 * the system initialization.
 *
 * EPICS INPUT FIELDS:
 * (char *)	A	current debug level
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
long initCad (struct cadRecord *pcad)
{
	int	debug;
	long	status;

	/*
	 * Get current debug level. Assume DBG_NONE if the value is
	 * not a valid number.
	 */
	if (scanInt (pcad->a, &debug) == 0)
	    debug = DBG_NONE;

	if (DEBUG_MIN)
	    errlogPrintf ("initCad: a=(%s), debug=%d\n", pcad->a, (int) debug);

	/*
	 * Branch on cad directive.
	 */
	switch (pcad->dir) {
	case menuDirectiveMARK:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveCLEAR:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectivePRESET:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTART:
	    if (DEBUG_FULL)
	        errlogPrintf ("initCAD: Accepted\n");
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTOP:
	    status = CAD_ACCEPT;
	    break;

	default:
	    errlogPrintf ("initCAD: invalid CAD directive\n");
	    status = CAD_REJECT;
	    break;
	}

	return status;
}

/*
 *+
 * FUNCTION NAME:
 * bootCad
 *
 * INVOCATION:
 * bootCad (pcad)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (!) pcad (struct cadRecord *pcad)	CAD record pointer
 * 
 * FUNCTION VALUE:
 * (long)       CAD_ACCEPTED	valid simulation level
 *		CAD_REJECTED	invalid CAD directive
 *
 * PURPOSE:
 * Reboot the system
 *
 * DESCRIPTION:
 * This routine is associated with the boot CAD record. It will trigger
 * the system reboot.
 *
 * EPICS INPUT FIELDS:
 * (char *)	A	current debug level
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
 *
 *-
 */
long bootCad (struct cadRecord *pcad)
{
	int	debug;
	long	status;

	/*
	 * Get current debug level. Assume DBG_NONE if the value is
	 * not a valid number.
	 */
	if (scanInt (pcad->a, &debug) == 0)
	    debug = DBG_NONE;

	if (DEBUG_MIN)
	    errlogPrintf ("bootCad: a=(%s), debug=%d\n", pcad->a, (int) debug);

	/*
	 * Branch on cad directive.
	 */
	switch (pcad->dir) {
	case menuDirectiveMARK:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveCLEAR:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectivePRESET:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTART:
	    if (DEBUG_FULL)
	        errlogPrintf ("bootCAD: Accepted\n");
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTOP:
	    status = CAD_ACCEPT;
	    break;

	default:
	    errlogPrintf ("bootCAD: invalid CAD directive\n");
	    status = CAD_REJECT;
	    break;
	}

	return status;
}

/*
 *+
 * FUNCTION NAME:
 * testCad name
 *
 * INVOCATION:
 * testCad (pcad)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (!) pcad (struct cadRecord *pcad)	CAD record pointer
 * 
 * FUNCTION VALUE:
 * (long)       CAD_ACCEPTED	valid simulation level
 *		CAD_REJECTED	invalid CAD directive
 *
 * PURPOSE:
 * Test the system
 *
 * DESCRIPTION:
 * This routine is associated with the test CAD record. It will trigger
 * the system self test.
 *
 * EPICS INPUT FIELDS:
 * (char *)	A	current debug level
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
long testCad (struct cadRecord *pcad)
{
	int	debug;
	long	status;

	/*
	 * Get current debug level. Assume DBG_NONE if the value is
	 * not a valid number.
	 */
	if (scanInt (pcad->a, &debug) == 0)
	    debug = DBG_NONE;

	if (DEBUG_MIN)
	    errlogPrintf ("testCad: a=(%s), debug=%d\n", pcad->a, (int) debug);

	/*
	 * Branch on cad directive.
	 */
	switch (pcad->dir) {
	case menuDirectiveMARK:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveCLEAR:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectivePRESET:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTART:
	    if (DEBUG_FULL)
	        errlogPrintf ("testCAD: Accepted\n");
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTOP:
	    status = CAD_ACCEPT;
	    break;

	default:
	    errlogPrintf ("testCAD: invalid CAD directive\n");
	    status = CAD_REJECT;
	    break;
	}

	return status;
}

/*
 *+
 * FUNCTION NAME:
 * logCad
 *
 * INVOCATION:
 * logCad (pcad)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (!) pcad (struct cadRecord *pcad)	CAD record pointer
 * 
 * FUNCTION VALUE:
 * (long)       CAD_ACCEPTED	valid simulation level
 *		CAD_REJECTED	invalid CAD directive
 *
 * PURPOSE:
 * Enable/disable logging
 *
 * DESCRIPTION:
 * This routine is associated with the log CAD record.
 *
 * EPICS INPUT FIELDS:
 * (char *)	A	logging on/off
 * (char *)	B	current debug level
 *
 * EPICS OUTPUT FIELDS:
 * (long)	VALA	logging flag
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * This is a noop routine since logging is still not implemented.
 *
 *-
 */
long logCad (struct cadRecord *pcad)
{
	int	debug;
	long	status;

	/*
	 * Get current debug level. Assume DBG_NONE if the value is
	 * not a valid number.
	 */
	if (scanInt (pcad->b, &debug) == 0)
	    debug = DBG_NONE;

	if (DEBUG_MIN) {
	    errlogPrintf ("logCad: a=(%s), b=(%s), debug=%d\n",
		      pcad->a, pcad->b, (int) debug);
	}

	/*
	 * Branch on cad directive.
	 */
	switch (pcad->dir) {
	case menuDirectiveMARK:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveCLEAR:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectivePRESET:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTART:
	    if (DEBUG_FULL)
	        errlogPrintf ("logCAD: Accepted\n");
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTOP:
	    status = CAD_ACCEPT;
	    break;

	default:
	    errlogPrintf ("logCAD: invalid CAD directive\n");
	    status = CAD_REJECT;
	    break;
	}

	return status;
}

/*
 *+
 * FUNCTION NAME:
 * wsSelCad
 *
 * INVOCATION:
 * wsSelCad (pcad)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (!) pcad (struct cadRecord *pcad)	CAD record pointer
 * 
 * FUNCTION VALUE:
 * (long)       CAD_ACCEPTED	valid debug level
 *		CAD_REJECTED	invalid debug level or cad directive
 *
 * PURPOSE:
 * Set the debug level
 *
 * DESCRIPTION:
 * This routine is associated with the weather station selection CAD record.
 * It checks the weather station name argument and writes weather station
 * number to an output field.
 *
 * EPICS INPUT FIELDS:
 * (char *)	A	requested weather station number
 * (long)	B	debug level
 *
 * EPICS OUTPUT FIELDS:
 * (long)	VALA	validated weather station number
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
long wsSelCad (struct cadRecord *pcad)
{
	int		debug;
	long		index, status;

	/*
	 * Must be the same options in the wsSelInput record. The
	 * order does not need to be the same.
	 */
	static char	*wsMenu[] =
			    {"PACHON", "SOAR", "CTIO", "CFHT", "UKIRT", NULL};

	/*
	 * Get current debug level. Assume DBG_NONE if the value is
	 * not a valid number.
	 */
	if (scanInt (pcad->b, &debug) == 0)
	    debug = DBG_NONE;

	if (DEBUG_MIN) {
	    errlogPrintf ("wsSelCad: a=(%s), b=(%s), debug=%d\n",
		      pcad->a, pcad->b, (int) debug);
	}

	/*
	 * Branch on CAD directive
	 */
	switch (pcad->dir) {
	case menuDirectiveMARK:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveCLEAR:
	    strcpy (pcad->a, "");
	    db_post_events (pcad, &pcad->a, 1);
	    status = CAD_ACCEPT;
	    break;

	case menuDirectivePRESET:

	    /*
	     * Look for the weather station name in the weather station
	     * menu. The weather station number is the index of the
	     * weather station name in the array.
	     */
	    index = scanMenu (wsMenu, pcad->a);

	    if (DEBUG_FULL)
		errlogPrintf ("wsSelCad: index=%ld\n", index);

	    if (index >= 0) {
		if (DEBUG_FULL) {
		    errlogPrintf ("wsSelCad: ACCEPTED index = %d\n",
			      (int) index);
		}
		*(long *) pcad->vala = index;
		strcpy (pcad->mess, "");
		status = CAD_ACCEPT;
	    } else {
		sprintf (pcad->mess,
		    "Must be PACHON|SOAR|CTIO|CFHT|UKIRT\n");
		status = CAD_REJECT;
	    }
	    break;

	case menuDirectiveSTART:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTOP:
	    status = CAD_ACCEPT;
	    break;

	default:
	    errlogPrintf ("wsSelCad: Invalid CAD directive\n");
	    status = CAD_REJECT;
	}

	return (status);
}

/*
 *+
 * FUNCTION NAME:
 * metSetupCad
 *
 * INVOCATION:
 * metSetupCad (pcad)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (!) pcad (struct cadRecord *pcad)	CAD record pointer
 * 
 * FUNCTION VALUE:
 * (long)       CAD_ACCEPTED	valid debug level
 *		CAD_REJECTED	invalid debug level or cad directive
 *
 * PURPOSE:
 * Set the particle size and sampling time for the MetOne dust monitor
 *
 * DESCRIPTION:
 *
 * EPICS INPUT FIELDS:
 * (char *)	A	requested particle size
 * (long)	B	requested sampling time
 * (long)	C	sampling time
 * (long)	D	debug level
 *
 * EPICS OUTPUT FIELDS:
 * (long)	VALA	particle size index (one indexed)
 * (long)	VALB	sampling time
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
long metSetupCad (struct cadRecord *pcad)
{
	int	debug;
	int	index, sample, scan;
	long	status;

	/*
	 * Must be the same options in the wsSelInput record. The
	 * order does not need to be the same.
	 */
	static char	*sizeMenu[] =
				{"0.5 micron", "1.0 micron",
				 "2.0 micron", "5.0 micron",
				 NULL};

	/*
	 * Get current debug level. Assume DBG_NONE if the value is
	 * not a valid number.
	 */
	if (scanInt (pcad->d, &debug) == 0)
	    debug = DBG_NONE;

	if (DEBUG_MIN) {
	    errlogPrintf ("metSetupCad: a=(%s), avg=(%s), smp=(%s), debug=%d\n",
		      pcad->a, pcad->b, pcad->c, (int) debug);
	}

	/*
	 * Branch on CAD directive
	 */
	switch (pcad->dir) {
	case menuDirectiveMARK:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveCLEAR:
	    strcpy (pcad->a, "");
	    strcpy (pcad->b, "");
	    strcpy (pcad->c, "");
	    db_post_events (pcad, &pcad->a, 1);
	    db_post_events (pcad, &pcad->b, 1);
	    db_post_events (pcad, &pcad->c, 1);
	    status = CAD_ACCEPT;
	    break;

	case menuDirectivePRESET:

	    status = CAD_ACCEPT;

	    if (scanInt (pcad->c, &scan) == 0) {
		sprintf (pcad->mess,
		    "Scan time must be an integer number");
		status = CAD_REJECT;
	    } else if (scan <= 0) {
		sprintf (pcad->mess,
		    "Scan time must greater than zero");
		status = CAD_REJECT;
	    }

	    if (DEBUG_FULL) {
		errlogPrintf ("metSetupCad: scan=%d, status=%ld\n",
			  scan, status);
	    }

	    if (scanInt (pcad->b, &sample) == 0) {
		sprintf (pcad->mess,
		    "Sampling time must an integer number");
		status = CAD_REJECT;
	    } else if (sample <= 0) {
		sprintf (pcad->mess,
		    "Sampling time must greater than zero");
		status = CAD_REJECT;
	    }

	    if (scan < sample) {
		sprintf (pcad->mess,
		    "Sampling time must < the scan time %d",
		    scan);
		status = CAD_REJECT;
	    }

	    if (DEBUG_FULL) {
		errlogPrintf ("metSetupCad: sample=%d, status=%ld\n",
			  sample, status);
	    }

	    /*
	     * Look for the particle size in the debug menu. The size
	     * index level is the index of the size string in the array.
	     */
	    index = scanMenu (sizeMenu, pcad->a);

	    if (DEBUG_FULL)
		errlogPrintf ("metSetupCad: index=%d\n", index);

	    /*
	     * If a match is found then write the size index to the
	     * corresponding output link and accept the command.
	     * Otherwise reject the command.
	     */
	    if (index < 0) {
		sprintf (pcad->mess, "Unknown particle size");
		status = CAD_REJECT;
	    }

	    /*
	     * Write values to the output links. Make sure to
	     * clear any previous error message.
	     */
	    if (status == CAD_ACCEPT) {
		index++;	/* should be one indexed */
		if (DEBUG_FULL) {
		    errlogPrintf ("metSetupCad: ACCEPTED index=%d, sample=%d\n",
			      (int) index, (int) sample);
		}
		*(long *) pcad->vala = index;
		*(long *) pcad->valb = sample;
		strcpy (pcad->mess, "");
	    }

	    break;

	case menuDirectiveSTART:
	    status = CAD_ACCEPT;
	    break;

	case menuDirectiveSTOP:
	    status = CAD_ACCEPT;
	    break;

	default:
	    errlogPrintf ("metSetupCad: Invalid CAD directive\n");
	    status = CAD_REJECT;
	}

	return (status);
}


epicsRegisterFunction(debugCad);
epicsRegisterFunction(simCad);
epicsRegisterFunction(metSetupCad);
epicsRegisterFunction(wsSelCad);
