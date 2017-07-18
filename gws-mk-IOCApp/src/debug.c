#include "gws.h"
#include    <epicsPrint.h>   

/*
 *+
 * FUNCTION NAME:
 * printBuffer
 *
 * INVOCATION:
 * printBuffer (buf, nbytes)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) buf (unsigned char *)	buffer to print
 * (>) nbytes (int)		number of bytes to print
 *
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Print buffer contents in ASCII format
 *
 * DESCRIPTION:
 * This routine will print the contents of a character buffer in ASCII
 * format. If the buffer contains non-printable characters it will print
 * the characters in hexadecimal format.
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
void printBuffer (unsigned char *buf, int nbytes)
{
	int		n;
	unsigned int	ch;

	if (buf == NULL) {
	    errlogPrintf ("printBuffer: null buffer pointer\n");
	    return;
	} else {
	    errlogPrintf ("printBuffer: %p, %d:\n", buf, nbytes);
	}

	for (n = 0; n < nbytes; n++) {
	    ch = *(buf + n);
	    if (isprint (ch))
		errlogPrintf ("[%c] ", ch);
	    else
		errlogPrintf ("[%02x] ", ch);
	}
	errlogPrintf ("\n");
}
