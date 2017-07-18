/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * paser.c
 *
 * FUNCTION NAME(S)
 * htmlParser	- Parse buffer containing data in HTML format
 * textParser	- Parse buffer containing data in text format
 *
 *INDENT-OFF*
 *INDENT-ON*
 */
 
#include "gws.h"

/*
 * Automaton states
 */
enum STATE {
    ST_START,
    ST_TAG,
    ST_DATA,
    ST_VALUE,
    ST_ERROR
};

/*
 * Maximum number of characters in the token word. This value should be
 * be big enough to handle the biggest tokens. Otherwise, the parser will
 * truncate token words to this value.
 */
#define	SZ_TOKEN		256

/*
 * Maximum number of patters allowed. There is no reason why there should
 * be a maximum number of patters, but having it avoids dynamic allocation
 * of memory inside the parser. This value should be big enough to handle
 * the biggest case or the number of patterns will be truncated.
 */
#define MAX_PATTERN	64

/*
 * Local functions.
 */
LOCAL int parse (char *, int, char *[], int, char *[], int, BOOL [],
		  int, BOOL);

/*
 *+
 * FUNCTION NAME:
 * htmlParse
 *
 * INVOCATION:
 * htmlParse (buf, nbuf, pat, npat, tok, maxchars, flags, debug)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) buf (char *)		buffer to parse
 * (>) nbuf (int)		number of characters in the buffer
 * (>) pat (char *[])		seeing monitor table
 * (>) npat (int)		number of patterns/tokens
 * (<) tok (char *[])		extracted tokens
 * (>) maxchars (int)		maximum number of characters in a token
 * (<) flags (BOOL [])		extracted tokens
 * (>) debug (int)		debug level (DBG_NONE/DBG_MIN/DBG_FULL)
 * 
 * FUNCTION VALUE:
 * (int)		ERROR if the parser goes into an unknown state
 *			OK otherwise
 *
 * PURPOSE:
 * Parse buffer containing data in HTML format
 *
 * DESCRIPTION:
 * This routine calls the general purpose parser with the html flag set
 * to TRUE. For more details see the parser description below.
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 *-
 */
int htmlParse (char *buf, int nbuf, char *pat[], int npat,
	       char *tok[], int maxchars, BOOL flag[], int debug)
{
	if (DEBUG_MIN) {
	    printErr ("htmlParse: buf=%x, nbuf=%d, npat=%d, maxchars=%d\n",
		      buf, nbuf, npat, maxchars);
	}

	return (parse (buf, nbuf, pat, npat, tok, maxchars, flag,
		       debug, TRUE));
}

/*
 *+
 * FUNCTION NAME:
 * htmlParse
 *
 * INVOCATION:
 * htmlParse (buf, nbuf, pat, npat, tok, maxchars, flags, debug)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) buf (char *)		buffer to parse
 * (>) nbuf (int)		number of characters in the buffer
 * (>) pat (char *[])		seeing monitor table
 * (>) npat (int)		number of patterns/tokens
 * (<) tok (char *[])		extracted tokens
 * (>) maxchars (int)		maximum number of characters in a token
 * (<) flags (BOOL [])		extracted tokens
 * (>) debug (int)		debug level (DBG_NONE/DBG_MIN/DBG_FULL)
 * 
 * FUNCTION VALUE:
 * (int)		ERROR if the parser goes into an unknown state
 *			OK otherwise
 *
 * PURPOSE:
 * Parse buffer containing data in text format
 *
 * DESCRIPTION:
 * This routine calls the general purpose parser with the html flag set
 * to FALSE. For more details see the parser description below.
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 *-
 */
int textParse (char *buf, int nbuf, char *pat[], int npat,
	       char *tok[], int maxchars, BOOL flag[], int debug)
{
	if (DEBUG_MIN) {
	    printErr ("textParse: buf=%x, nbuf=%d, npat=%d, maxchars=%d\n",
		      buf, nbuf, npat, maxchars);
	}

	return (parse (buf, nbuf, pat, npat, tok, maxchars, flag,
		       debug, FALSE));
}

/*
 *+
 * FUNCTION NAME:
 * parse
 *
 * INVOCATION:
 * parse (buf, nbuf, pat, npat, tok, maxchars, flags, debug)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) buf (char *)		buffer to parse
 * (>) nbuf (int)		number of characters in the buffer
 * (>) pat (char *[])		seeing monitor table
 * (>) npat (int)		number of patterns/tokens
 * (<) tok (char *[])		extracted tokens
 * (>) maxchars (int)		maximum number of characters in a token
 * (<) flags (BOOL [])		extracted tokens
 * (>) debug (int)		debug level (DBG_NONE/DBG_MIN/DBG_FULL)
 * (>) html (BOOL)		HTML data? (TRUE/FALSE)
 * 
 * FUNCTION VALUE:
 * (int)		ERROR if the parser goes into an unknown state
 *			OK otherwise
 *
 * PURPOSE:
 * Parse buffer containing text or HTML data
 *
 * DESCRIPTION:
 * This routine looks for a set of pattern strings in the buffer and when
 * any of these is found the next word is extracted as the value. No data
 * type conversion is attempted. Any whitespace defined by isspace() is
 * assumed to be a word delimiter defined by isspace() is assumed to be a
 * word delimiter. Trailing white spaces are removed from the word as well.
 *
 * This routine is the back end for textParse() and htmlParse(). The only
 * difference between both is that in the case of htmlParse data inside
 * HTML tags is ignored as possible data values (search patterns are not).
 *
 * The callers is supposed to supply an array of character pointers where
 * the different values for each search pattern is found. The space for all
 * the data values should be allocated by the caller.
 *
 * The routine also returns an array of data flags that tell te caller what
 * patterns where found, i.e. what data values are valid.
 *
 * In the current implementation no more than MAX_PATTERN patterns are
 * allowed. Also, the maximum size of a data word cannot be more than
 * SZ_TOKEN. If they do, the routine will silently truncate them.
 *
 * This routine will only return ERROR if the automaton goes into an unknown
 * state. This shouldn't happen because the automaton code does not generate
 * illegal states. However, a memory corruption could overrride the state
 * and create an error like this.
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 *-
 */
LOCAL int parse (char *buf, int nbuf, char *pat[], int npat,
		 char *tok[], int maxchars, BOOL flag[],
		 int debug, BOOL html)
{
	char	ch;
	int	n, k, index, cpos;
	int	npatmax, cposmax;
	int	state;
	char	word[SZ_TOKEN];
	char	*cptr[MAX_PATTERN];

	if (DEBUG_MIN) {
	    printErr ("parse: buf=%x, nbuf=%d, npat=%d, maxchars=%d, html=%d\n",
		      buf, nbuf, npat, maxchars, html);
	}

	/*
	 * Initialize automaton state, max number of patterns, and
	 * max number of characters in a token word. Minus one is
	 * substracted from the latter to avoid doing this operation
	 * in the loop.
	 */
	state    = ST_START;
	npatmax  = (npat > MAX_PATTERN)  ? MAX_PATTERN : npat;
	cposmax  = (maxchars > SZ_TOKEN) ? SZ_TOKEN - 1 : maxchars - 1;

	if (DEBUG_FULL) {
	    printErr ("parse: npatmax=%d, cposmax=%d\n", npatmax, cposmax);
	}

	/*
	 * Initialize character pointer arrays. These are used to keep
	 * track of the last character of the pattern seen in the input.
	 * They are reset to the beginning of the pattern every time the
	 * input character breaks the pattern.
	 */
	for (n = 0; n < npatmax; n++)
	    cptr[n] = pat[n];

	/*
	 * Initialize output flags. These are used to tell the caller
	 * what patterns were found in the buffer.
	 */
	for (n = 0; n < npatmax; n++)
	    flag[n] = FALSE;

	/* Loop over all characters in the input buffer. Stop iteration
	 * if an error is detected.
	 */
	for (n = 0; n < nbuf && state != ST_ERROR; n++) {

	    ch = *(buf + n);

	    switch (state) {
	    case ST_START:
		if (DEBUG_FULL)
		    printErr ("parse, ST_START: ch=%c\n", ch);
		/*
		 * The program will get here when looking for a pattern.
		 * If there is a match it'll move to the next state.
		 */
		for (k = 0; k < npat; k++) {
		    if (ch == *cptr[k]) {
			if (*(++(cptr[k])) == '\0') {
			    state    = ST_DATA;
			    index    = k;
			    cptr[k]  = pat[k];
			    if (DEBUG_FULL)
			        printErr ("parse, MATCH: k=%d\n", k);
			}
		    } else
			cptr[k] = pat[k];
		}
		break;

	    case ST_DATA:
		/*
		 * A matching pattern was found; look for the start of
		 * the data. Skip HTML tags if the html flag is set.
		 */
		if (DEBUG_FULL)
		    printErr ("parse, ST_DATA: ch=%c\n", ch);
		if (html && ch == '<')
		    state = ST_TAG;
		else if (!isspace(ch)) {
		    cpos = 0;
		    word[cpos++] = ch;
		    state = ST_VALUE;
		}
		break;

	    case ST_VALUE:
		if (DEBUG_FULL)
		    printErr ("parse, ST_VALUE: ch=%c, cpos=%d\n", ch, cpos);
		/*
		 * The start of the data was found; continue parsing
		 * the value until a whitespace is found.
		 */
		if (isspace(ch)) {
		    word[cpos]   = '\0';
		    flag[index] = TRUE;		/* found pattern */
		    if (DEBUG_FULL) {
			printErr (
			    "parse, Found word=(%s), cpos=%d, index=%d\n",
			    word, cpos, index);
		    }
		    state = ST_START;
		    strcpy (tok[index], word);
		} else if (cpos < cposmax)
		    word[cpos++] = ch;
		break;

	    case ST_TAG:
		if (DEBUG_FULL)
		    printErr ("parse, ST_TAG: ch=%c\n", ch);
		/*
		 * The start of an HTML tag was found. Skip
		 * everything until the end of the tag.
		 */
		if (ch == '>')
		    state = ST_DATA;
		break;

	    default:
		logMsg ("Unknown state %d\n", (int) state, 0,0,0,0,0);
		state = ST_ERROR;
	    }
	}

	/* Take care of the case the automaton ending in ST_DATA when the
	 * start of data is detected, but no more data is found (single
	 * character case).
	 */
	if (state == ST_DATA) {
	    word[cpos] = '\0';
	    strcpy (tok[index], word);
	}

	/* Check for errors.
	 */
	if (state != ST_ERROR)
	    return (OK);
	else
	    return (ERROR);
}
