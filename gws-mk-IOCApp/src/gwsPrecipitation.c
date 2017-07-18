/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * gwsPrecipitation.c
 *
 * FUNCTION NAME(S)
 * nullSub		- Noop routine for sub records
 * carCombine		- Combine status of several CAR records
 * heartbeatSub		- Check heartbeat and set health accordingly
 * maxLongValue		- Calculate the maximum value in long input links
 * dewCalc		- Calculate dew point
 * atan2deg		- Calculate the arc tanget of y/x in degrees
 * setWindDirAlarm	- Set the alarm value according to the Wind direction.
 *
 *INDENT-OFF*
 *INDENT-ON*
 */

#include "gws.h"

#include    <epicsPrint.h>   
#include <genSubRecord.h>
#include <epicsExport.h>
#include <registryFunction.h>
#include <iocsh.h> 


/*
 * Precipitation sensor activation states.
 */
#define SENSOR_ENABLED		1
#define SENSOR_DISABLED		0

/*
 * Precipitation sensor alarm states. Should map with the health
 * OK, WARNING and GOOD values since the dm screens will be using
 * the health color rule for alarm colors. In this way we avoid
 * having yet another color rule in the user interface.
 */
#define ALARM_NONE		0
#define ALARM_WARNING		1
#define ALARM_ERROR		2

/*
 * Sensor states. The sensors are a 0/1 signal from a bi record.
 */
#define SENSOR1_INPUT		*((long *) (pgsub->a))
#define SENSOR2_INPUT		*((long *) (pgsub->b))
#define SENSOR3_INPUT		*((long *) (pgsub->c))
#define SENSOR4_INPUT		*((long *) (pgsub->d))
#define DEBUG_LEVEL		*((long *) (pgsub->j))

/*
 * Output alarm states. Alarm states can be OK, WARNING or ERROR. The dm
 * screens will use the health color rule to control based on this value.
 */
#define SENSOR1_ALARM		*((long *) (pgsub->vala))
#define SENSOR2_ALARM		*((long *) (pgsub->valb))
#define SENSOR3_ALARM		*((long *) (pgsub->valc))
#define SENSOR4_ALARM		*((long *) (pgsub->vald))

/*
 *+
 * FUNCTION NAME:
 * precipitationAlarms
 *
 * INVOCATION:
 * precipitationAlarms (pgsub)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) pgsub (struct genSubRecord *) gensub record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always zero
 *
 * PURPOSE:
 * Determine precipitation sensor alarms
 *
 * DESCRIPTION:
 * This routine is called from a "genSub" 
 *
 * EPICS INPUT FIELDS:
 * (long) A	sensor 1 activation state
 * (long) B	sensor 1 activation state
 * (long) C	sensor 1 activation state
 * (long) D	sensor 1 activation state
 * (long) J	debug level
 *
 * EPICS OUTPUT FIELDS:
 * (long) VALA	alarm state for sensor 1
 * (long) VALB	alarm state for sensor 2
 * (long) VALC	alarm state for sensor 3
 * (long) VALD	alarm state for sensor 4
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
long precipitationAlarms (struct genSubRecord *pgsub)
{
	int	n, debug;
	int	nactive = 0;
	int	state[4], alarm[4];

	/*
	 * Initialize record field pointers.
	 */
	debug = DEBUG_LEVEL;
	/* debug = DBG_FULL; */
	if (DEBUG_MIN)
	    errlogPrintf ("precipitationAlarms: debug=%d\n", (int) debug);

	/*
	 * Read sensor states into an array
	 */
	state[0] = SENSOR1_INPUT;
	state[1] = SENSOR2_INPUT;
	state[2] = SENSOR3_INPUT;
	state[3] = SENSOR4_INPUT;

	/*
	 * Count how many sensors are active. This has to be done
	 * before evaluating the alarm for each sensor since they
	 * depend on the total number of sensors active.
	 */
	for (n = 0; n < 4; n++) {
	    if (state[n] == SENSOR_ENABLED)
		nactive ++;
	}

	/*
	 * Set up the alarms for each sersor based on the value of
	 * the sensor and the number of sensors active.
	 */
	for (n = 0; n < 4; n++) {
	    if (state[n] == SENSOR_ENABLED) {
		if (nactive < 3)
		    alarm[n] = ALARM_WARNING;
		else
		    alarm[n] = ALARM_ERROR;
	    } else
		alarm[n] = ALARM_NONE;
	}

	if (DEBUG_FULL) {
	    errlogPrintf("precipitationAlarms: nactive=%d\n", nactive);
	    for (n = 0; n <4; n++)
		errlogPrintf("  %d: state=%d, alarm=%d\n", n, state[n], alarm[n]);
	}

	/*
	 * Write alarms to the output links.
	 */
	SENSOR1_ALARM = alarm[0];
	SENSOR2_ALARM = alarm[1];
	SENSOR3_ALARM = alarm[2];
	SENSOR4_ALARM = alarm[3];

	return (0L);
}
epicsRegisterFunction(precipitationAlarms);
