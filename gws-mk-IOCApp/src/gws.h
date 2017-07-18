#ifndef INCgwsH
#define INCgwsH

/*
 * ANSI C
 */
#include <epicsStdioRedirect.h>
#include <epicsStdlib.h>
#include <string.h>
#include <ctype.h>
#include <epicsStdioRedirect.h>
/*
 * vxWorks
 */
#include <epicsExit.h>
#include <epicsThread.h>
#include <epicsEvent.h>
#include <devLib.h>

/*
 * EPICS
 */
#include <dbEvent.h>

/*
 * Maximum size of strings in EPICS.
 */
#define	SZ_EPICS_STRING	40

/*
 * Maximum size of common strings.
 */
#define	SZ_WORD		50	/* single word string */
#define	SZ_LINE		100	/* input line */

/*
 * Debug levels
 */
#define DBG_NONE	0	/* no debug */
#define DBG_MIN		1	/* trace program */
#define DBG_FULL	2	/* full debug */
#define	MAX_DEBUG	3	/* max number of debug levels */

/*
 * Debug macros
 */
#define DEBUG_MIN	(debug > DBG_NONE)
#define DEBUG_FULL	(debug > DBG_MIN)

/*
 * Angle conversion macros.
 */
#define RAD2DEG(x)	(x * 180.0 / 3.14159265359)
#define DEG2RAD(x)	(x * 3.14159265359 / 180.0)

/* 
 * Maximum number of simulation levels.
 */
#define	MAX_SIMUL	4

/*
 * Simulation levels
 */
#define SIMM_NONE	0	/* no simulation */
#define SIMM_VSM	1	/* command parse, no actions */
#define SIMM_FAST	2	/* cmd parse, action, non-realistic times */
#define SIMM_FULL	3	/* cmd parse, actions, realistic times */

/*
 * Health values.
 */
#define	HEALTH_GOOD	0
#define	HEALTH_WARNING	1
#define	HEALTH_BAD	2
#define	HEALTH_INVALID	3

/*
 * IOC states.
 */
#define	BOOTING		0
#define	INITIALISING	1
#define	RUNNING		2

/*
 * Weather station codes.
 */
#define	WS_PACHON	0
#define	WS_SOAR		1
#define	WS_CTIO		2
#define	WS_CFHT		3
#define	WS_UKIRT	4
#define MAX_WS		5	/* max number of weather stations */

#define	ERROR	-1
#define	OK	 0 

#if 0
/*
 * Particle size indices (one indexed).
 */
#define	MET_0_5		1	/* 0.5 cmicron */
#define	MET_1_0		2	/* 1.0 cmicron */
#define	MET_2_0		3	/* 2.0 cmicron */
#define	MET_3_0		5	/* 3.0 cmicron */
#endif

/*
 * External functions.
 */
void	printBuffer (unsigned char *, int);
#if 0
int	webSetDebug (char *, int);
int	SeeingSetDebug (int);
#endif
double	dewCalc (double, double);
double	atan2deg (double, double);
int	textParse (char *, int, char *[], int, char *[], int, int [], int);
int	htmlParse (char *, int, char *[], int, char *[], int, int [], int);

#endif
