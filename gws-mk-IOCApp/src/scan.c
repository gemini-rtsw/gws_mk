#include "gws.h"
#include    <epicsPrint.h>   

/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * scan.c
 *
 * FUNCTION NAME(S)
 * scanInt		- Scan string for integer decimal value
 * scanDouble		- Scan string for real (double) value
 * scanMenu		- Look for a string in a menu of options
 *
 * MODULE DESCRIPTION
 * String scanning routines
 *
 *INDENT-OFF*
 * $Log: scan.c,v $
 * Revision 1.2  2005/02/11 06:43:20  pedro
 * Added scanMenu routine
 *
 * Revision 1.1  2005/02/01 03:47:32  pedro
 * Added environmental sensors
 *
 *INDENT-ON*
 */
 
#include "scan.h"

/*
 * States used in the automatons used to parse an int and double. The
 * automaton will enter each of these states after a given character
 * is found.
 */
enum {
    ST_START,		/* start */
    ST_SIGN,		/* sign */
    ST_DECIMAL1,	/* decimal digit before decimal point */
    ST_DECIMAL2,	/* decimal digit after decimal point */
    ST_DOT1,		/* decimal point before any numbers */
    ST_DOT2,		/* decimal point after numbers */
    ST_E,		/* "e" or "E" */
    ST_EXPONENT,	/* exponent decimal digit */
    ST_ESIGN,		/* exponent sign */
    ST_BLANK,		/* blank (space) */
    ST_ERROR		/* error */
} STATE;

/*
 * Compile time debug flags.
 */
#define	DEBUG_INT	FALSE
#define DEBUG_DOUBLE	FALSE

/*
 *+
 * FUNCTION NAME:
 * scanInt
 *
 * INVOCATION:
 * scanInt (str, ival)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) str (char *)	string to scan
 * (<) ival (int *)	integer value
 * 
 * FUNCTION VALUE:
 * (int)       number of values scanned (0 or 1)
 *
 * PURPOSE:
 * Scan string for integer decimal value
 *
 * DESCRIPTION:
 * This routine is almost equivalent to sscanf (str, "%d", ival), but it scans
 * it's more restrictive: it allows only a single integer value, spaces are
 * allowed only at the beginning or the end of the string, and only decimal
 * digits are considered valid.
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
int scanInt (char *str, int *ival)
{
	char	c;
	int	n, len;
	int	nchars = 0;
	int	state  = ST_START;

	/*
	 * Return immediately if the string is empty.
	 */
	len = strlen (str);
	if (len == 0)
	    return (0);

	/*
	 * Loop over all characters in the input string. Stop if
	 * an error is detected or if there are no more characters
	 * in the input string.
	 */
	for (n = 0; n < len && state != ST_ERROR; n++) {

	    c = *(str + n);

	    switch (state) {
	    case ST_START:	/* starting state */
#if DEBUG_INT
printf ("ST_START: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == '-' || c == '+')
		    state = ST_SIGN;	
		else if (isdigit((int)c))
		    state = ST_DECIMAL1;
		else if (c != ' ')	/* leading blanks */
		    state = ST_ERROR;
		break;

	    case ST_SIGN:	/* sign found */
#if DEBUG_INT
printf ("ST_SIGN: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (isdigit((int)c))
		    state = ST_DECIMAL1;
		else
		    state = ST_ERROR;
		break;

	    case ST_DECIMAL1:	/* digit found */
#if DEBUG_INT
printf ("ST_DECIMAL: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == ' ')
		    state = ST_BLANK;
		else if (!isdigit((int)c))
		    state = ST_ERROR;
		break;

	    case ST_BLANK:	/* trailing blanks */
		if (c != ' ')
		    state = ST_ERROR;
		break;

	    default:
		errlogPrintf ("scanInit: Illegal state %d\n", (int)state);
	    }
	}

#if DEBUG_INT
printf ("end: state=%d\n", state);
#endif

	if (state != ST_ERROR)
	    nchars = (sscanf (str, "%d", ival) > 0) ? 1 : 0;

	return (nchars);
}

/*
 *+
 * FUNCTION NAME:
 * scanDouble
 *
 * INVOCATION:
 * scanDouble (str, dval)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) str (char *)	string to scan
 * (<) dval (int *)	double value
 * 
 * FUNCTION VALUE:
 * (int)       number of values scanned (0 or 1)
 *
 * PURPOSE:
 * Scan string for real (double) value
 *
 * DESCRIPTION:
 * This routine is almost equivalent to sscanf (str, "%g", gval), but it scans
 * it's more restrictive: it allows only a single double value, spaces are
 * allowed only at the beginning or the end of the string, and only decimal
 * digits are considered valid. Exponential notation is allowed with an 'e'
 * or 'E'.
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
int scanDouble (char *str, double *dval)
{
	char	c;
	int	n, len;
	int	nchars = 0;
	int	state  = ST_START;

	/*
	 * Return immediately if the string is empty.
	 */
	len = strlen (str);
	if (len == 0)
	    return (0);

	/*
	 * Loop over all characters in the input string. Stop if
	 * an error is detected or if there are no more characters
	 * in the input string.
	 */
	for (n = 0; n < len && state != ST_ERROR; n++) {

	    c = *(str + n);

	    switch (state) {
	    case ST_START:	/* starting state */
#if DEBUG_DOUBLE
printf ("ST_START: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == '-' || c == '+')
		    state = ST_SIGN;
		else if (c == '.')
		    state = ST_DOT1;
		else if (isdigit((int)c))
		    state = ST_DECIMAL1;
		else if (c != ' ')
		    state = ST_ERROR;
		break;

	    case ST_SIGN:	/* sign (+/-) found */
#if DEBUG_DOUBLE
printf ("ST_SIGN: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == '.')
		    state = ST_DOT1;
		else if (isdigit((int)c))
		    state = ST_DECIMAL1;
		else
		    state = ST_ERROR;
		break;

	    case ST_DOT1:	/* decimal point found before any digits */
#if DEBUG_DOUBLE
printf ("ST_DOT1: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (isdigit((int)c))
		    state = ST_DECIMAL2;
		else
		    state = ST_ERROR;
		break;

	    case ST_DECIMAL1:	/* digit found before decimal point */
#if DEBUG_DOUBLE
printf ("ST_DECIMAL1: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == '.')
		    state = ST_DOT2;
		else if (c == ' ')
		    state = ST_BLANK;
		else if (c == 'e' || c == 'E')
		    state = ST_E;
		else if (!isdigit((int)c))
		    state = ST_ERROR;
		break;

	    case ST_DOT2:	/* decimal point found after digits */
#if DEBUG_DOUBLE
printf ("ST_DOT2: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == ' ')
		    state = ST_BLANK;
		else if (c == 'e' || c == 'E')
		    state = ST_E;
		else if (isdigit((int)c))
		    state = ST_DECIMAL2;
		else
		    state = ST_ERROR;
		break;

	    case ST_DECIMAL2:	/* digit found after decimal point */
#if DEBUG_DOUBLE
printf ("ST_DECIMAL2: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == ' ')
		    state = ST_BLANK;
		else if (c == 'e' || c == 'E')
		    state = ST_E;
		else if (!isdigit((int)c))
		    state = ST_ERROR;
		break;

	    case ST_E:		/* exponent (e|E) found */
#if DEBUG_DOUBLE
printf ("ST_E: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == '-' || c == '+')
		    state = ST_ESIGN;
		else if (isdigit((int)c))
		    state = ST_EXPONENT;
		else
		    state = ST_ERROR;
	   	break;

	    case ST_ESIGN:	/* sign found after exponent */
#if DEBUG_DOUBLE
printf ("ST_ESIGN: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (isdigit((int)c))
		    state = ST_EXPONENT;
		else
		    state = ST_ERROR;
		break;

	    case ST_EXPONENT:	/* digit in exponent found */
#if DEBUG_DOUBLE
printf ("ST_EXPONENT: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c == ' ')
		    state = ST_BLANK;
		else if (!isdigit((int)c))
		    state = ST_ERROR;
		break;

	    case ST_BLANK:	/* trailing blanks */
#if DEBUG_DOUBLE
printf ("ST_BLANK: n=%d, len=%d, c=%c, state=%d\n", n, len, c, state);
#endif
		if (c != ' ')
		    state = ST_ERROR;
		break;

	    default:
		errlogPrintf ("scanInit: Illegal state %d\n", (int)state);
	    }
	}

#if DEBUG_DOUBLE
printf ("end: state=%d\n", state);
#endif

	if (state != ST_ERROR)
	    nchars = (sscanf (str, "%lg", dval) > 0) ? 1 : 0;

	return (nchars);
}

/*
 *+
 * FUNCTION NAME:
 * scanMenu
 *
 * INVOCATION:
 * scanMenu (menu, str)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) menu (char *[])	menu string
 * (>) str (char *)	string to look for
 * 
 * FUNCTION VALUE:
 * (int)		string position in the menu
 *
 * PURPOSE:
 * Look for a string in a menu of options
 *
 * DESCRIPTION:
 * This routine looks for a given string in a menu of possible options. If
 * the string is found it returns the position of the string in the menu
 * (zero indexed). Otherwise returns a negative number. The menu is a NULL
 * terminated array of character strings.
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
 * Will go into an infinite loop (or crash) if the menu is not NULL
 * terminated.
 *-
 */
int scanMenu (char *menu[], char *str)
{
	int	n, index;

	for (n = 0, index = -1; menu[n] != NULL; n++) {
	    if (strcmp (str, menu[n]) == 0) {
		index = (long) n;
		break;
	    }
	}

	return (index);
}
