#ifndef INChttpH
#define INChttpH

/*
 * Max number of characters in strings.
 */
#define	SZ_HOST		40		/* host name/ip */
#define	SZ_URL		100		/* url */
#define	SZ_HTTPREQ	150		/* http request string. IT should be
					   greater than SZ_URL + SZ_HOST */
#if 0
/*
 * Timeout when opening a web site.
 */
#define OPEN_TIMEOUT	20		/* seconds */

/*
 * Timeout used while waiting for data from a web site.
 */
#define	READ_TIMEOUT	10		/* seconds */

/*
 * Delay used to retry opening a web site when the open fails.
 * In general when a site is down or not responding is better
 * to wait for a reasonable time.
 */
#define	OPEN_DELAY	300		/* seconds = 5 min */
#endif

/* Function calls.
 */
extern void	httpRequest (char *, char *); 

#endif
