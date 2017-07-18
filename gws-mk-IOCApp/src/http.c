/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * http.c
 *
 * DESCRIPTION
 * HTTP routines
 *
 * FUNCTION NAME(S)
 * httpRequest		- Format HTTP request
 *
 *INDENT-OFF*
 *INDENT-ON*
 */

#include "stdio.h"
#include "http.h"

/*
 *+
 * FUNCTION NAME:
 * httpRequest
 *
 * INVOCATION:
 * httpRequest (url, req)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) url (char *)	URL of web page
 * (<) req (char *)	HTTP request
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Format an HTTP request
 *
 * DESCRIPTION:
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
void httpRequest (char *url, char *req)
{
	sprintf (req, "GET %s HTTP/1.0\r\n\r\n", url);
}
