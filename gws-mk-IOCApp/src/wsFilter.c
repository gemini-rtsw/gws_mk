/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * wsFilter.c
 *
 * FUNCTION NAME(S)
 * wsFilterInit      - Initialize data filtering
 * wsFilterProc      - Filter data and calculate statistics
 * wsFilterStat      - Calculate data statistics
 * wsFilterDump      - Dump data buffer to console
 * wsFilterFileDump   - Dump all data buffers into files
 * wsFilteCountDump   - Dump data filtering and rejection counters
 *
 *INDENT-OFF*
 * $Log: wsFilter.c,v $
 * Revision 1.2  2004/07/23 15:48:06  pedro
 * Modified code to handle the change in the links.
 *
 * Revision 1.1  2003/10/23 17:42:14  pedro
 * Added routines to calculate statistics
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
#include "databuf.h"

#include <math.h>
#include <genSubRecord.h>
#include <epicsTimer.h>
#include <epicsTime.h>
#include <epicsPrint.h>   
#include <epicsExport.h>
#include <registryFunction.h>
#include <iocsh.h> 

/*
 * Limit values used to reject data. Some values like the pressure, 
 * temperature and wind speed must be suitable for the most extreme cases
 * in a wide range of sites since this module cannot (yet) be configured
 * for site specific conditions.
 */
#if 1
#define TEMP_MIN      -20   /* C */
#define TEMP_MAX      40
#define WSPEED_MIN      0   /* m/s */
#define WSPEED_MAX      60
#define WDIR_MIN      0   /* degrees */
#define WDIR_MAX      360
#define PRESS_MIN      600   /* hPa */
#define PRESS_MAX      800
#define HUMID_MIN      0   /* % */
#define HUMID_MAX      100
#endif

#if 0
/* REMOVE THIS DEFINITIONS AT THE TELESCOPE  */
#define TEMP_MIN      -200000   /* C */
#define TEMP_MAX      400000
#define WSPEED_MIN      -200000   /* m/s */
#define WSPEED_MAX      600000
#define WDIR_MIN      -200000   /* degrees */
#define WDIR_MAX      360000
#define PRESS_MIN      600000   /* hPa */
#define PRESS_MAX      800000
#define HUMID_MIN      -200000   /* % */
#define HUMID_MAX      100000
#endif
/*
 * Input fields for the wsFilterProc routine.
 */
#define   IN_TEMP         *((double *) pgsub->a)
#define   IN_WSPEED      *((double *) pgsub->c)
#define   IN_WDIR         *((double *) pgsub->e)
#define   IN_PRESS      *((double *) pgsub->g)
#define   IN_HUMID      *((double *) pgsub->i)
#define   IN_HEALTH      *((long *)   pgsub->k)
#define   IN_MESSAGE       ((char *)   pgsub->m)
#define   IN_UPDATE      *((long *)   pgsub->q)
#define   IN_DEBUG      *((long *)   pgsub->t)

/*
 * Output fields for the wsFilterProc routine.
 */
#define   OUT_TEMP      *((double *) pgsub->vala)
#define   OUT_WSPEED      *((double *) pgsub->valb)
#define   OUT_WDIR      *((double *) pgsub->valc)
#define   OUT_PRESS      *((double *) pgsub->vald)
#define   OUT_HUMID      *((double *) pgsub->vale)
#define OUT_DEW         *((double *) pgsub->valf)

#define   OUT_AVG5_TEMP      *((double *) pgsub->valg)
#define   OUT_AVG5_WSPEED      *((double *) pgsub->valh)
#define   OUT_AVG5_WDIR      *((double *) pgsub->vali)
#define   OUT_AVG5_PRESS      *((double *) pgsub->valj)
#define   OUT_AVG5_HUMID      *((double *) pgsub->valk)

#define   OUT_AVG30_TEMP      *((double *) pgsub->vall)
#define   OUT_AVG30_WSPEED   *((double *) pgsub->valm)
#define   OUT_AVG30_WDIR      *((double *) pgsub->valn)
#define   OUT_AVG30_PRESS      *((double *) pgsub->valo)
#define   OUT_AVG30_HUMID      *((double *) pgsub->valp)

#define   OUT_MESSAGE       ((char *)   pgsub->valt)
#define   OUT_HEALTH      *((long *)   pgsub->valu)

/*
 * Indices used to reference each of the elements of the dataBuf,
 * dataFiltered, dataInvalid, dataMinLimits, and dataMaxLimits arrays.
 * DATA_WDIRX and DATA_WDIRY are introduced to store the X and Y components
 * of the wind direction, and are used internally to calculate the average
 * and standard deviation of the wind direction.
 */
#define DATA_TEMP      0      /* temperature */
#define DATA_WSPEED      1      /* wind speed */
#define DATA_WDIR      2      /* wind direction */
#define DATA_PRESS      3      /* pressure */
#define DATA_HUMID      4      /* humidity */
#define LAST_DATA      DATA_HUMID   /* last physical data */
                  /* */
#define DATA_WDIRX      5      /* x component of wind dir. */
#define DATA_WDIRY      6      /* y component of wind dir. */
                  /* */
#define MAX_DATA      7      /* used to allocate arrays */
                  /* must be the last index +1 */
/*
 * Maximum number of data points used for filtering and statistics.
 * This number should be big enough to store at least half an hour of
 * samples at a max sampling rate of five seconds.
 */
#define   MAX_BUFFER      400      /* 33 minutes */

/*
 * Macro used to normalize angles between [0,360] and [-180,180] degrees.
 */
#define MOD360(x)      ((x>360)?x-360:((x<   0)?x+360:x))
#define MOD180(x)      ((x>180)?x-360:((x<-180)?x+360:x))

/*
 * Data buffers use for filtering and statistics.
 */
LOCAL struct dataBuffer      dataBuf[MAX_DATA];

/*
 * Variables used to count how many times data was rejected because it
 * was out of the valid data rages (garbage).
 */
LOCAL long         dataInvalid[MAX_DATA];

/*
 * Variables used to count how many times data was filtered out because it
 * was too far from the average value. The minimum and maximum values for
 * the X and Y components of the wind direction are defined to avoid having
 * to deal with special cases in the code. Although they are ignored in the
 * code the values must be such that no errors are reported when the code
 * checks for limit values.
 */
LOCAL long         dataFiltered[MAX_DATA];

LOCAL double         dataMinLimits[] = {TEMP_MIN,
                     WSPEED_MIN,
                     WDIR_MIN,
                     PRESS_MIN,
                     HUMID_MIN,
                     -2.0,
                     -2.0};

LOCAL double         dataMaxLimits[] = {TEMP_MAX,
                     WSPEED_MAX,
                     WDIR_MAX,
                     PRESS_MAX,
                     HUMID_MAX,
                     2.0,
                     2.0};

LOCAL void wsFilterStat (struct dataBuffer dbuf[], double xmin, int debug,
          double avg[], double sig[], int fstat[]);

/*
 *+
 * FUNCTION NAME:
 * wsFilterInit
 *
 * INVOCATION:
 * wsFilterInit (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (CODE) name (C_type)   parameter description
 * 
 * FUNCTION VALUE:
 * (>) pgsub (struct subRecord *)   gensub record pointer
 *
 * PURPOSE:
 * Initialize data filtering
 *
 * DESCRIPTION:
 * This routine allocates all the buffers used to store data for statistics
 * and clears all counters used to keep track of the times the data is
 * rejected.
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
long wsFilterInit (struct genSubRecord *pgsub)
{
   int   n;

   errlogPrintf ("wsFilterInit: initializing data filtering parameters\n");

   /*
    * Clear counters used to keep track of the number of times
    * data has been rejected because it way out of range or because
    * it has been filtered out.
    */
   for (n = 0; n < MAX_DATA; n++) {
       dataInvalid[n]  = 0;
       dataFiltered[n] = 0;
   }

   /*
    * Allocate data buffers. The wind direction buffer is not
    * allocated because the actual wind speed is not used for
    * the statistics. Instead the X and Y components of the wind
    * speed are used.
    */
   for (n = 0; n < MAX_DATA; n++) {
       if (dataAlloc (&dataBuf[n],  MAX_BUFFER) == ERROR) {
      errlogPrintf ("wsFilterInit: cannot allocate data buffer %d\n",n);
       }
   }

   return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * wsFilterProc
 *
 * INVOCATION:
 * wsFilterProc (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (CODE) name (C_type)   parameter description
 * 
 * FUNCTION VALUE:
 * (>) pgsub (struct subRecord *)   gensub record pointer
 *
 * PURPOSE:
 * Filter data and calculate statistics
 *
 * DESCRIPTION:
 * Filter weather station data and calculate the 5 and 30 minute average
 * and standard deviation (the latter is not written to output links).
 * Note: Filtering is not implemented yet.
 *
 * EPICS INPUT FIELDS:
 * (double) A   temperature (C)
 * (double) C   wind speed (m/s)
 * (double) E   wind direction (degrees)
 * (double) G   pressure (hPa)
 * (double) I   relative humidity (%)
 * (long)   K   health
 *
 * EPICS OUTPUT FIELDS:
 * (double) A   filtered temperature (C)
 * (double) B   filtered wind speed (m/s)
 * (double) C   filtered wind direction (degrees)
 * (double) D   filtered pressure (hPa)
 * (double) E   filtered humidity (%)
 * (double) F   calculated dew point (C)
 * (long)   U   filtered health
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * This routine is not reentrant
 *-
 */
long wsFilterProc (struct genSubRecord *pgsub)
{
   int   n;
   long   health, debug, update;
   double   delta = 0.0;
   epicsTimeStamp   time;
   double   xmin;
   double   val[MAX_DATA];
   double   avg5[MAX_DATA], sig5[MAX_DATA];
   double   avg30[MAX_DATA], sig30[MAX_DATA];
   int   fval[MAX_DATA], fstat5[MAX_DATA], fstat30[MAX_DATA];

   static double   x;
   static epicsTimeStamp   otime;
   static int   first = TRUE;   /* first time executing */

   /*
    * Read input links.
    */
   val[DATA_TEMP]   = IN_TEMP;
   val[DATA_WSPEED] = IN_WSPEED;
   val[DATA_WDIR]   = IN_WDIR;
   val[DATA_PRESS]  = IN_PRESS;
   val[DATA_HUMID]  = IN_HUMID;
   health           = IN_HEALTH;
   debug            = IN_DEBUG;
   update           = IN_UPDATE;

   if (DEBUG_MIN) {
       errlogPrintf (
      "wsFilterProc: t=%g, ws=%g, wd=%g, p=%g, h=%g, d=%ld, u=%ld\n",
      val[DATA_TEMP], val[DATA_WSPEED], val[DATA_WDIR],
      val[DATA_PRESS], val[DATA_HUMID],
      debug, update);

   }

   /*
    * Skip record execution if the update field is not set. This
    * field is used to tell this processing routine when the record
    * gets triggered, but no new data is available. Make sure that
    * the health gets updated regardless of the update flag because
    * when the weather station is disabled there is no data available.
    */
   if (update == FALSE) {
       if (DEBUG_FULL)
      errlogPrintf ("wsFilterProc: no update\n");
       OUT_HEALTH = health;
       strcpy (OUT_MESSAGE, IN_MESSAGE);
       return (0L);
   }

   /*
    * Calculate the X & Y components of the wind direction.
    */
   val[DATA_WDIRX] = cos (DEG2RAD(val[DATA_WDIR]));
   val[DATA_WDIRY] = sin (DEG2RAD(val[DATA_WDIR]));

   /*
    * Check for valid ranges. All data out of the valid limits
    * is marked as invalid. There is no need to skip the X & Y
    * components of the wind direction since the flags for these
    * components are not used anyway. Set the health to WARNING
    * if any of the data points is rejected unless it was WARNING
    * or BAD already.
    */
    for (n = 0; n < MAX_DATA; n++) {
       if (val[n] < dataMinLimits[n] || val[n] > dataMaxLimits[n]) {
      errlogPrintf ("wsFilterProc: data number %d out of range. Value=%f\n",n,val[n]);
      dataInvalid[n]++;
      fval[n] = FALSE;
#if 0
      if (health == HEALTH_GOOD)
          health = HEALTH_WARNING;
#endif
       } else
      fval[n] = TRUE;
   }

   /*
    * Calculate the X value as relative increments of the system
    * time starting from zero. 
    */
   epicsTimeGetCurrent(&time);
   if (first) {
       x     = 0.0;
       first = FALSE;
   } else {
       delta = epicsTimeDiffInSeconds(&time,  &otime);
       x += delta;
   }

   if (DEBUG_FULL) {
       errlogPrintf (
      "first=%d, time=%ld, otime=%ld, delta=%f, x=%g\n",
      first, (long)time.secPastEpoch, (long)otime.secPastEpoch, delta, x);
   }

   /*
    * Save time for the next iteration.
    */
   otime  = time;

   /*
    * Accumulate (valid) data into the data buffers. The X and Y
    * components of the wind direction are stored as well as the
    * original wind direction for the average and standard deviation
    * calculations because they avoid the discontinuity in the zero
    * to 360 transition.
    */
   for (n = 0; n < MAX_DATA; n++) {
       if (fval[n]) {
      dataEnter (&dataBuf[n], x, val[n]);
       }
   }

   /*
    * Calculate statistics.
    */
   /* x is in seconds */
   xmin = x - 300;         /* 5 minutes ago */
   wsFilterStat (dataBuf, xmin, debug, avg5,  sig5,  fstat5);
   xmin = x - 1800;       /* 30 minutes ago */
   wsFilterStat (dataBuf, xmin, debug, avg30, sig30, fstat30);

   /*
    * Update (valid) data in output links.
    */
   if (fval[DATA_TEMP])
       OUT_TEMP = val[DATA_TEMP];
   if (fval[DATA_WSPEED])
       OUT_WSPEED = val[DATA_WSPEED];
   if (fval[DATA_WDIR])
       OUT_WDIR = val[DATA_WDIR];
   if (fval[DATA_PRESS])
       OUT_PRESS = val[DATA_PRESS];
   if (fval[DATA_HUMID])
       OUT_HUMID = val[DATA_HUMID];
   if (fval[DATA_TEMP] && fval[DATA_HUMID])
       OUT_DEW = dewCalc (val[DATA_TEMP], val[DATA_HUMID]);
   OUT_HEALTH = health;

   /*
    * Update (valid) averages in output links.
    */
   if (fstat5[DATA_TEMP])
       OUT_AVG5_TEMP = avg5[DATA_TEMP];
   if (fstat5[DATA_WSPEED])
       OUT_AVG5_WSPEED = avg5[DATA_WSPEED];
   if (fstat5[DATA_WDIR])
       OUT_AVG5_WDIR =  avg5[DATA_WDIR];
   if (fstat5[DATA_PRESS])
       OUT_AVG5_PRESS = avg5[DATA_PRESS];
   if (fstat5[DATA_HUMID])
       OUT_AVG5_HUMID = avg5[DATA_HUMID];

   if (fstat30[DATA_TEMP])
       OUT_AVG30_TEMP = avg30[DATA_TEMP];
   if (fstat30[DATA_WSPEED])
       OUT_AVG30_WSPEED = avg30[DATA_WSPEED];
   if (fstat30[DATA_WDIR])
       OUT_AVG30_WDIR = avg30[DATA_WDIR];
   if (fstat30[DATA_PRESS])
       OUT_AVG30_PRESS = avg30[DATA_PRESS];
   if (fstat30[DATA_HUMID])
       OUT_AVG30_HUMID = avg30[DATA_HUMID];

   return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * wsFilterStat
 *
 * INVOCATION:
 * wsFilterStat (dbuf, xmin, xmax, debug, avg, sig, fstat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dbuf (struct dataBuffer [])   data buffer array
 * (>) xmin (double)         first point of the buffer to use
 * (>) xmax (double)         last point of the buffer to use
 * (>) debug (int)         debug level
 * (<) avg (double[])         array of calculated averages
 * (<) sig (double[])         array of calculated standard dev.
 * (<) fstat (int[])         array of valid statistic flags
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Calculate data statistics
 *
 * DESCRIPTION:
 * This routine calculates the average and the standard deviation of all
 * data buffers in a range of data points, defined by it's X coordinate
 * (time). It also returns an array of flags used to tell whether the
 * calculated averages and sigmas are well defined.
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
LOCAL void wsFilterStat (struct dataBuffer dbuf[], double xmin, int debug,
          double avg[], double sig[], int fstat[])
{
   int   n;

   /*
    * Calculate the statistics for all the buffers in memory. Skip
    * the wind direction since its statistics are derived from the
    * X & Y components.
    */
   for (n = 0; n < MAX_DATA; n++) {
       if (n == DATA_WDIR)
      continue;
       if (dataStat (&dbuf[n], xmin, &avg[n], &sig[n]) > 0)
      fstat[n] = TRUE;
       else
      fstat[n] = FALSE;
   }

   /*
    * Calculate the statistics of the wind direction from the X & Y
    * components. Combine the X & Y statistic flags to get the wind
    * direction flag.
    */
   fstat[DATA_WDIR] = fstat[DATA_WDIRX] && fstat[DATA_WDIRY];
   if (fstat[DATA_WDIR]) {
       avg[DATA_WDIR] = atan2deg (avg[DATA_WDIRY], avg[DATA_WDIRX]);
       sig[DATA_WDIR] = RAD2DEG (sqrt (sig[DATA_WDIRX] * sig[DATA_WDIRX] +
                  sig[DATA_WDIRY] * sig[DATA_WDIRY]));
   }

   if (DEBUG_FULL) {
       errlogPrintf ("wsFilterStat: xmin=%g\n", xmin);
       errlogPrintf ("wsFilterStat, avg: t=%g, ws=%g, wd=%g, p=%g, h=%g\n",
            avg[DATA_TEMP],
            avg[DATA_WSPEED], avg[DATA_WDIR],
            avg[DATA_PRESS], avg[DATA_HUMID]);
       errlogPrintf ("wsFilterStat, sig: t=%g, ws=%g, wd=%g, p=%g, h=%g\n",
            sig[DATA_TEMP], sig[DATA_WSPEED],
            sig[DATA_WDIR],
            sig[DATA_PRESS], sig[DATA_HUMID]);
   }
}


/*
 *+
 * FUNCTION NAME:
 * wsFilterCountDump
 *
 * INVOCATION:
 * wsFilteCountDump ()
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * None
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Dump data filtering and rejection counters
 *
 * DESCRIPTION:
 * This routine writes the contents of the variables used to count how many
 * data has been rejected based on filtering or out of bounds criteria.
 * This is a vxWorks shell callable routine used for debugging purposes.
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
void wsFilterCountDump ()
{
   errlogPrintf ("\nwsFilterDump\n");
   errlogPrintf ("tempInvalid=%ld\n",    dataInvalid[DATA_TEMP]);
   errlogPrintf ("wspeedInvalid=%ld\n",  dataInvalid[DATA_WSPEED]);
   errlogPrintf ("wdirInvalid=%ld\n",    dataInvalid[DATA_WDIR]);
   errlogPrintf ("pressInvalid=%ld\n",   dataInvalid[DATA_PRESS]);
   errlogPrintf ("humidInvalid=%ld\n",   dataInvalid[DATA_HUMID]);
   errlogPrintf ("tempFiltered=%ld\n",   dataFiltered[DATA_TEMP]);
   errlogPrintf ("wspeedFiltered=%ld\n", dataFiltered[DATA_WSPEED]);
   errlogPrintf ("wdirFiltered=%ld\n",   dataFiltered[DATA_WDIR]);
   errlogPrintf ("pressFiltered=%ld\n",  dataFiltered[DATA_PRESS]);
   errlogPrintf ("humidFiltered=%ld\n",  dataFiltered[DATA_HUMID]);
}

/*
 *+
 * FUNCTION NAME:
 * wsFilterDump
 *
 * INVOCATION:
 * wsFilterump ()
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) ndata (int)      data buffer index
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Dump data buffer to console
 *
 * DESCRIPTION:
 * This routine writes the contents of a data buffer to the console. The
 * data buffer is identified by an index that varies from zero to MAX_DATA
 * minus one. This is a vxWorks shell callable routine used for debugging
 * purposes.
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
void wsFilterDataDump (int ndata)
{
   if (ndata >= 0 || ndata < MAX_DATA) {
       dataDump (&dataBuf[ndata]);
   } else {
       errlogPrintf ("wsFilterDataDump: index must be between 0 and %d\n",
            MAX_DATA - 1);
   }
}

/*
 *+
 * FUNCTION NAME:
 * wsFilterFileDump
 *
 * INVOCATION:
 * wsFilterFileDump ()
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * None
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Dump all data buffers into files
 *
 * DESCRIPTION:
 * This routine writes the contents of all data buffers in this module into
 * separate files. This is a vxWorks shell callable and is used for debugging
 * purposes.
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
void wsFilterFileDump ()
{
   int   n;
   char   *fname;

   for (n = 0; n < MAX_DATA; n++) {
       if (n == DATA_TEMP) {
      fname = "wsFilterTemp.dat";
       } else if (n == DATA_WSPEED) {
      fname = "wsFilterWspeed.dat";
       } else if (n == DATA_WDIR) {
      fname = "wsFilterWdir.dat";
       } else if (n == DATA_PRESS) {
      fname = "wsFilterPress.dat";
       } else if (n == DATA_HUMID) {
      fname = "wsFilterHumid.dat";
       } else if (n == DATA_WDIRX) {
      fname = "wsFilterWdirX.dat";
       } else if (n == DATA_WDIRY) {
      fname = "wsFilterWdirY.dat";
       } else {
      errlogPrintf ("Index not found\n");
      break;
       }
       if (dataFileDump (&dataBuf[n], fname) == ERROR) {
      errlogPrintf (
          "wsFilterFileDump: Cannot open file %d: %s\n", n, fname);
      break;
       }
   }
}
epicsRegisterFunction(wsFilterProc);
epicsRegisterFunction(wsFilterInit);
epicsRegisterFunction(wsFilterFileDump);
epicsRegisterFunction(wsFilterDataDump);
epicsRegisterFunction(wsFilterCountDump);
