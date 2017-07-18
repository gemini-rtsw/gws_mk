/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * gwsMisc.c
 *
 * FUNCTION NAME(S)
 * nullSub      - Noop routine for sub records
 * carCombine      - Combine status of several CAR records
 * maxLongValue      - Calculate the maximum value in long input links
 * dewCalc      - Calculate dew point
 * atan2deg      - Calculate the arc tanget of y/x in degrees
 * setWindDirAlarm   - Set the alarm value according to the Wind direction.
 *
 *INDENT-OFF*
 * $Log: gwsMisc.c,v $
 * Revision 1.8  2012/02/07 13:59:25  gemvx
 *  Committing in .
 *
 * Modified Files:
 *    Makefile Makefile.Dirs RELEASE.NOTES adl/colors.adl
 * adl/gwsMaster.adl capfast/wsInter.sch src/gwsInitCP.pv
 * Added Files:
 *    adl/colorsCP.adl adl/windAlarms.adl
 * ----------------------------------------------------------------------
 *
 * Revision 1.8  2016/10/14 18:13:24  mikew
 * Moved heartbeatSub() to wsWeb module
 *
 * Revision 1.7  2005/09/06 18:13:24  pedro
 * Changed references to 40 in string lengths to SZ_EPICS_STRING.
 *
 * Revision 1.6  2005/02/01 03:47:32  pedro
 * Added environmental sensors
 *
 * Revision 1.5  2003/10/23 17:47:10  pedro
 * Misc changes.
 *
 * Revision 1.4  2003/05/14 20:46:21  pedro
 * Moved printBufer() into new debug file.
 *
 * Revision 1.3  2002/05/31 19:35:10  pedro
 * Installed V1-0 (first official CVS release).
 *
 *INDENT-ON*
 */

#include "gws.h"

#include <math.h>

#include <subRecord.h>
#include <genSubRecord.h>
#include <menuCarstates.h>
#include <epicsTime.h>

#include <epicsPrint.h>   
#include <epicsExport.h>
#include <registryFunction.h>
#include <iocsh.h> 

/*
 * Maximum number of CAR states that can be combined in carCombine.
 */
#define   MAX_CAR_STATES      9

#define VAL_EPICS_STRING 40

/*
 * Default number of times the heartbeatSub routine can execute before
 * changing the health to BAD if no changes are seen in the heartbeat.
 * This number is calculated as follows:
 *
 *   max = timeout_time(seconds) / scan_time(seconds)
 */
#define   DEF_FROZEN_COUNT   6   /* 1 minute, at 10 second scan rate */

/*
 * Constants used in the dew point calculation by dewCalc().
 */
#define C1         0.0001846
#define ABS_ZERO      273.16      /* 0 Celcius -> K */
#define TEMP_MAX      50.0
#define TEMP_MIN      -40.0
#define HUMID_MAX      100.0
#define HUMID_MIN      0.0

/*
 * Input and output fields for the heartbeatSub routine.
 */
#define IN_HEARTBEAT_TIMEOUT   *((long *) pgsub->a)
#define IN_HEARTBEAT_HB      *((long *) pgsub->b)
#define IN_HEARTBEAT_DEBUG   *((long *) pgsub->f)
#define   OUT_HEARTBEAT_HEALTH   *((long *) pgsub->vala)
#define   OUT_HEARTBEAT_OLDHB   *((long *) pgsub->valb)
#define   OUT_HEARTBEAT_OLDTIME   *((long *) pgsub->valc)

/*
 * Input and output fields for the gwsTimer routine.
 */
#define IN_TRG_DELAY      *((long *) pgsub->a)
#define IN_TRG_COUNTER      *((long *) pgsub->b)
#define OUT_TRG_ENABLE      *((long *) pgsub->valc)

/*
 * Input and output fields for the nextProc routine.
 */
#define   IN_NEXT_DEBUG      *((long            *) pgsub->t)
#define   IN_NEXT_DISA1      *((short           *) pgsub->b)
#define   IN_NEXT_DISA2      *((short           *) pgsub->d)
#define   IN_NEXT_DISA3      *((short           *) pgsub->f)
#define   IN_NEXT_DISA4      *((short           *) pgsub->h)
#define   IN_NEXT_DISA5      *((short           *) pgsub->j)
#define   IN_NEXT_VAL      *((double          *) pgsub->o)
#define   OUT_NEXT_SEL      *((unsigned short  *) pgsub->valm)
#define   OUT_TIMESTAMP1      *((long            *) pgsub->valp)
#define   OUT_TIMESTAMP2      *((long            *) pgsub->valq)
#define   OUT_TIMESTAMP3      *((long            *) pgsub->valr)
#define   OUT_TIMESTAMP4      *((long            *) pgsub->vals)
#define   OUT_TIMESTAMP5      *((long            *) pgsub->valt)


/*
 *+
 * FUNCTION NAME:
 * nullSub
 *
 * INVOCATION:
 * nullSub (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) pgsub (struct subRecord *)   pointer to gensub record
 * 
 * FUNCTION VALUE:
 * (long)       always returns zero
 *
 * PURPOSE:
 * Noop routine for sub records
 *
 * DESCRIPTION:
 * This routine is intended for the initilization routine of sub records.
 * The initialization routine is required even if it's not needed.
 *
 * EPICS INPUT FIELDS:
 * None
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
long nullSub (struct subRecord *psub)
{
   return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * carCombine
 *
 * INVOCATION:
 * carCombine (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) pgsub (C_type)   parameter description
 * 
 * FUNCTION VALUE:
 * (long)       always zero
 *
 * PURPOSE:
 * Combine status of several CAR records
 *
 * DESCRIPTION:
 * This routine is called from a "genSub" and combines the status and 
 * message values from up to nine CAR records into an output state and
 * message. The highest priority is BUSY, then ERR, and finally IDLE.
 * If no BUSY states are found, then it checks is for any ERR states in
 * which case the message associated with the first ERR encountered is
 * output.
 *
 * EPICS INPUT FIELDS:
 * (long) A   state of CAR record #1
 * (long) B   message of CAR record #1
 *
 * (long) C   state of CAR record #2
 * (long) D   message of CAR record #2
 *
 * (long) E   state of CAR record #3
 * (long) F   message of CAR record #3
 *
 * (long) G   state of CAR record #4
 * (long) H   message of CAR record #4
 *
 * (long) I   state of CAR record #5
 * (long) K   message of CAR record #5
 *
 * (long) L   state of CAR record #6
 * (long) M   message of CAR record #6
 *
 * (long) N   state of CAR record #7
 * (long) O   message of CAR record #7
 *
 * (long) P   state of CAR record #8
 * (long) Q   message of CAR record #8
 *
 * (long) R   state of CAR record #9
 * (long) S   message of CAR record #9
 *
 * (long) T   debug level
 *
 * EPICS OUTPUT FIELDS:
 * (long) VALA   combined CAR state
 * (long) VALB   combined CAR message
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * If more than one CAR state is ERR only the first one detected by
 * the routine is passed to the output.
 *-
 */
long carCombine (struct genSubRecord *pgsub)
{
   int   n;
   long   debug, val;
   long   *outval;
   char   *outmess, *msg;
   char   *mess[MAX_CAR_STATES];
   long   *cval[MAX_CAR_STATES];

   /*
    * Initialize record field pointers.
    */
   cval[0] = (long *) (pgsub->a);
   cval[1] = (long *) (pgsub->c);
   cval[2] = (long *) (pgsub->e);
   cval[3] = (long *) (pgsub->g);
   cval[4] = (long *) (pgsub->i);
   cval[5] = (long *) (pgsub->l);
   cval[6] = (long *) (pgsub->n);
   cval[7] = (long *) (pgsub->p);
   cval[8] = (long *) (pgsub->r);
   mess[0] = (char *) (pgsub->b);
   mess[1] = (char *) (pgsub->d);
   mess[2] = (char *) (pgsub->f);
   mess[3] = (char *) (pgsub->h);
   mess[4] = (char *) (pgsub->k);
   mess[5] = (char *) (pgsub->m);
   mess[6] = (char *) (pgsub->o);
   mess[7] = (char *) (pgsub->q);
   mess[8] = (char *) (pgsub->s);
   outval  = (long *) (pgsub->vala);
   outmess = (char *) (pgsub->valb);
   debug   = *((long *) (pgsub->t));

   if (DEBUG_MIN)
       errlogPrintf ("carCombine: debug=%d\n", (int) debug);

   /*
    * Default CAR state value.
    */
   val = menuCarstatesIDLE;
   msg = "";

   /*
    * Check if any subsystems are in ERROR state.
    */
   for (n = 0; n < MAX_CAR_STATES; n++) {
       if (*cval[n] == menuCarstatesERROR) {
      val = menuCarstatesERROR;
      msg = mess[n];
      if (DEBUG_FULL)
          errlogPrintf ("carCombine: Found ERROR state at n=%d\n", n);
      break;
       }
   }

   /*
    * Overwrite if any subsystems are in BUSY state.
    */
   for (n = 0; n < MAX_CAR_STATES; n++) {
       if (*cval[n] == menuCarstatesBUSY) {
      val = menuCarstatesBUSY;
      if (DEBUG_FULL)
          errlogPrintf ("carCombine: Found BUSY state at n=%d\n", n);
      break;
       }
   }

   /*
    * Update output links.
    */
   *outval = val;
   strncpy (outmess, msg, SZ_EPICS_STRING);

   return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * maxLongValue
 *
 * INVOCATION:
 * maxLongValue (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) pgsub (struct genSubRecord *)   gensub record pointer
 * 
 * FUNCTION VALUE:
 * (long)   always zero
 * 
 * PURPOSE:
 * Calculate the maximum value in long input links
 *
 * DESCRIPTION:
 * This routine returns the maximum value from input links A to J in a
 * gensub record. The output value is written to VALA.
 *
 * EPICS INPUT FIELDS:
 * (long) A   input value
 * (long) B   input value
 * (long) C   input value
 * (long) D   input value
 * (long) E   input value
 * (long) F   input value
 * (long) G   input value
 * (long) H   input value
 * (long) I   input value
 * (long) J   input value
 *
 * EPICS OUTPUT FIELDS:
 * (long) VALA   maximum value
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
long maxLongValue (struct genSubRecord *pgsub)
{
   long   max;

   max = *((long *) pgsub->a);

   if (*((long *) pgsub->b) > max)
       max = *((long *) pgsub->b);
   if (*((long *) pgsub->c) > max)
       max = *((long *) pgsub->c);
   if (*((long *) pgsub->d) > max)
       max = *((long *) pgsub->d);
   if (*((long *) pgsub->e) > max)
       max = *((long *) pgsub->e);
   if (*((long *) pgsub->f) > max)
       max = *((long *) pgsub->f);
   if (*((long *) pgsub->g) > max)
       max = *((long *) pgsub->g);
   if (*((long *) pgsub->h) > max)
       max = *((long *) pgsub->h);
   if (*((long *) pgsub->i) > max)
       max = *((long *) pgsub->i);
   if (*((long *) pgsub->j) > max)
       max = *((long *) pgsub->j);

   *((long *) pgsub->vala) = max;

   return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * dewCalc
 *
 * INVOCATION:
 * dewCalc (temp, humid)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) temp  (double)   temperature in Celcius
 * (>) humid (double)   relative humdity (0-100%)
 * 
 * FUNCTION VALUE:
 * (double)       dew point
 *
 * PURPOSE:
 * Calculate dew point
 *
 * DESCRIPTION:
 * This routine calculates the dew point using the same algorithm used
 * in the Gemini TCS. The temperature and humidity values are limited
 * to avoid overflows in the formula.
 *
 * EPICS INPUT FIELDS:
 * None
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
double dewCalc (double temp, double humid)
{
   double   dewpoint;

   /*
    * Limit temaperature and humdity ranges to reasonable values
    * prevent overflows in the dew point caluculation.
    */
    
   /* temp  = min (max (temp,  -40),  50);
   humid = min (max (humid, 0.1), 100); */

   /*
    * Convert temperature to Kelvin and convert the humidity to
    * the range from 0 to 1.0 before calculating the dew point.
    */
   temp  = temp + ABS_ZERO;
   humid = humid / 100.0;
   dewpoint = 1.0 / (1.0 / temp - C1 * log(humid)) - ABS_ZERO;

   return (dewpoint);
}

/*
 *+
 * FUNCTION NAME:
 * atan2deg
 *
 * INVOCATION:
 * atan2deg (y, x)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) y (double)   Y coordinate of a vector
 * (>) x (double)   X coordinate of a vector
 * 
 * FUNCTION VALUE:
 * (double)       arc tangent of y/x in degrees
 *
 * PURPOSE:
 * Calculate the arc tanget of y/x in degrees
 *
 * DESCRIPTION:
 * This routine calculates the arc tangent of y/x i degrees corrected in
 * such a way that angles always are in the range [0, 360].
 *
 * EPICS INPUT FIELDS:
 * None
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
double atan2deg (double y, double x)
{
   double  angle;

   angle = RAD2DEG(atan2 (y, x));
   if (angle < 0)
       angle += 360;

   return (angle);
}


/*
 *+
 * FUNCTION NAME:
 * nextProc
 *
 * INVOCATION:
 * nextProc (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (CODE) name (C_type)   parameter description
 * 
 * FUNCTION VALUE:
 * (>) pgsub (struct subRecord *)   gensub record pointer
 *
 * PURPOSE:
 * Start records in sequence taking into account disabled ones
 *
 * DESCRIPTION:
 * This routine is intended to be used in a gensub record to allow starting
 * up to five records in a sequence, but skipping those that are disabled
 * (DISA=1). The gensub record can only start a given record at a time and
 * its the responsability of the schematic logic to call the gensub record
 * again.
 *
 * EPICS INPUT FIELDS:
 * (LONG) B   Disable value 1
 * (LONG) D   Disable value 2
 * (LONG) F   Disable value 3
 * (LONG) H   Disable value 4
 * (LONG) J   Disable value 5
 * (LONG) O   Record to start up
 * (LONG) T   Debug level
 *
 * EPICS OUTPUT FIELDS:
 * (LONG) VALM   Selection mask
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
long nextProc (struct genSubRecord *pgsub)
{
   int    disa[5];
   int   n, sel, val;
   int   debug;
   time_t  time;
   epicsTimeStamp ts;


   /*
    * Read input links.
    */
   debug   = IN_NEXT_DEBUG;
   disa[0] = IN_NEXT_DISA1;
   disa[1] = IN_NEXT_DISA2;
   disa[2] = IN_NEXT_DISA3;
   disa[3] = IN_NEXT_DISA4;
   disa[4] = IN_NEXT_DISA5;
   val     = IN_NEXT_VAL;

   if (DEBUG_MIN)
       errlogPrintf ("nextProc: debug=%d\n", debug);

   /*
    * Check that value is in range.
    */
   if (val < 0 || val > 5) {
       errlogPrintf ("nextProc: Illegal value %d\n", val);
       return (0L);
   }

   /*
    * Loop looking for the next record not disabled.
    */
   for (n = val, sel = 6; n < 5; n++) {
       if (disa[n] == 0) {
      sel = n + 1;
      break;
       }
   }

   /*
    * Write time stamp.
    */
   epicsTimeGetCurrent(&ts);
   epicsTimeToTime_t(&time, &ts);
   switch (val) {
   case 1:
       OUT_TIMESTAMP1 = time;
       break;
   case 2:
       OUT_TIMESTAMP2 = time;
       break;
   case 3:
       OUT_TIMESTAMP3 = time;
       break;
   case 4:
       OUT_TIMESTAMP4 = time;
       break;
   case 5:
       OUT_TIMESTAMP5 = time;
       break;
   }

   /*
    * Write output links.
    */
   OUT_NEXT_SEL = sel;

   if (DEBUG_FULL) {
       errlogPrintf ("nextProc: val=%d\n", val);
       errlogPrintf ("          disa[0]=%d\n", disa[0]);
       errlogPrintf ("          disa[1]=%d\n", disa[1]);
       errlogPrintf ("          disa[2]=%d\n", disa[2]);
       errlogPrintf ("          disa[3]=%d\n", disa[3]);
       errlogPrintf ("          disa[4]=%d\n", disa[4]);
       errlogPrintf ("              sel=%d\n", sel);
   }

   return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * gwsTimer
 *
 * INVOCATION:
 * gwsTimer (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) pgsub (struct genSubRecord *)   pointer to gensub record
 * 
 * FUNCTION VALUE:
 * (long)    Always zero
 *
 * PURPOSE:
 * Make records process every certain number of seconds
 *
 * DESCRIPTION:
 * This routine is intended to be used with a gensub record connected
 * to a fanout record. The gensub record should process every second
 * and when the delay is over it sets the mask to a value such that
 * the forward link is propagated.
 *
 * EPICS INPUT FIELDS:
 * (DOUBLE) A      Timer delay
 *
 * EPICS OUTPUT FIELDS:
 * (type) field      Selection mask
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
long gwsTimer (struct genSubRecord *pgsub)
{
   if (IN_TRG_DELAY > 0) {
       IN_TRG_COUNTER = IN_TRG_COUNTER + 1;
       if (IN_TRG_COUNTER >= IN_TRG_DELAY) {
      IN_TRG_COUNTER = 0;
      OUT_TRG_ENABLE = 0;   /* enable */
       } else 
      OUT_TRG_ENABLE = 1;   /* disable */
   }

   return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * setWindDirAlarm
 *
 * INVOCATION:
 * setWindDirAlarm (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) pgsub (struct genSubRecord *)   pointer to gensub record
 * 
 * FUNCTION VALUE:
 * (long)    Always zero
 *
 * PURPOSE:
 * Set the warning level according to the Wind Direction.
 *
 * DESCRIPTION:
 * This routine is intended to be used with a gensub record.
 * The gensub record will read teh wind direction and will set the warning
 * level according to this value (NO_ALARM, MINOR, MAJOR, INVALID)
 *
 * EPICS INPUT FIELDS:
 * (DOUBLE) A      Wind Direction
 * (DOUBLE) B      Wind Alarm limit 1
 * (DOUBLE) C      Wind Alarm limit 2
 * (DOUBLE) D      Wind Alarm limit 3
 * (DOUBLE) E      Wind Alarm limit 4
 *
 * EPICS OUTPUT FIELDS:
 * (STRING) VALA        Warning level (NO_ALARM, MINOR, MAJOR, INVALID)
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
long setWindDirAlarm (struct genSubRecord *pgsub)
{
double WindDir;
double limit1, limit2, limit3, limit4;

    WindDir = *((double *) pgsub->a);
    limit1 = *((double *) pgsub->b);
    limit2 = *((double *) pgsub->c);
    limit3 = *((double *) pgsub->d);
    limit4 = *((double *) pgsub->e);

    if ( (limit1 == -1.0) || (limit2 == -1.0) || (limit3 == -1.0) || (limit4 == -1.0))
        return (0);

    if ( ((WindDir < limit1) && (WindDir >= 0.0)) || 
    ((WindDir > limit4) && (WindDir <= 360.0)) )
   strncpy ( ((char *) (pgsub->vala)), "NO_ALARM",VAL_EPICS_STRING);
    else if ( ((WindDir >= limit1) && (WindDir <= limit2)) || 
         ((WindDir > limit3) && (WindDir <= limit4)) )
   strncpy ( ((char *) (pgsub->vala)), "MINOR",VAL_EPICS_STRING);
    else if ( (WindDir >= limit2) && (WindDir <= limit3) )
   strncpy ( ((char *) (pgsub->vala)), "MAJOR",VAL_EPICS_STRING);
    else 
   strncpy ( ((char *) (pgsub->vala)), "INVALID",VAL_EPICS_STRING);

    return (0);
}
epicsRegisterFunction(carCombine);
epicsRegisterFunction(nextProc);
epicsRegisterFunction(gwsTimer);
epicsRegisterFunction(maxLongValue);
epicsRegisterFunction(setWindDirAlarm);
epicsRegisterFunction(nullSub);
