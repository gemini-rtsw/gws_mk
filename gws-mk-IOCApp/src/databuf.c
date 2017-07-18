/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * databuf.c
 *
 * FUNCTION NAME(S)
 * dataAlloc		- Allocate and initialize data buffer
 * dataFree		- Free all memory used by the data buffer
 * dataClear		- Clear data in the data buffer
 * dataEnter		- Enter data pair into data buffer
 * dataNpts		- Return the number of data pairs in data buffer
 * dataSize		- Return the data buffer size in data pairs
 * dataStat		- Calculate data buffer statistics
 * dataDump		- Dump contents of used part of data buffer
 * dataFileDump		- Dump contents of used part of data buffer to a file
 * dataRawDump		- Dump contents of the whole data buffer (raw)
 *
 * DESCRIPTION
 * This module provide routines to enter data into a circular buffer. The
 * length of the buffer is defined at creation time so only up to the
 * buffer size numbers can be stored in the buffer at the same time. Old
 * values are overwritten as new values are entered. A routine to calculate
 * buffer statistics (average, standard deviation) is also provided.
 *
 *INDENT-OFF*
 * $Log: databuf.c,v $
 * Revision 1.2  2004/07/23 15:43:27  pedro
 * Changed name of databuf structure to be more consistent with naming conventions.
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
#include <epicsPrint.h>   

#include <math.h>

#define DEBUG_DATABUF		0

LOCAL void dataFpDump (struct dataBuffer *, FILE *);

/*
 *+
 * FUNCTION NAME:
 * dataAlloc
 *
 * INVOCATION:
 * dataAlloc (dat, maxpts)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * (>) maxpts (int)			number of doubles to allocate in buffer
 * 
 * FUNCTION VALUE:
 * (int)	OK		ok
 *		ERROR		could not allocate memory, or
 *				zero or negative number of data points
 *
 * PURPOSE:
 * Allocate and initialize the data buffer
 *
 * DESCRIPTION:
 * This routine initializes the data buffer structure and allocates the
 * memory to store 'maxpts' double precision numbers.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
int dataAlloc (struct dataBuffer *dat, int maxpts)
{
#if DEBUG_DATABUF
	errlogPrintf ("dataAlloc: dat=%x, maxpts=%d\n", dat, maxpts);
#endif

	if (maxpts <= 0)
	    return (ERROR);

	dat->index  = 0;
	dat->count  = 0;
	dat->size   = maxpts;
	dat->buffer = (struct dataPair *)
			malloc (maxpts * sizeof (struct dataPair));

	if (dat->buffer != NULL)
	    return (OK);
	else
	    return (ERROR);
}

/*
 *+
 * FUNCTION NAME:
 * dataFree
 *
 * INVOCATION:
 * dataFree (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Free data buffer
 *
 * DESCRIPTION:
 * This routine resets all the data buffer structure counters and frees
 * the allocated buffer.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
void dataFree (struct dataBuffer *dat)
{
#if DEBUG_DATABUF
	errlogPrintf ("dataFree: dat=%x\n", dat);
#endif
	dataClear (dat);
	dat->size  = 0;;
	if (dat->buffer != NULL)
	    free (dat->buffer);
}

/*
 *+
 * FUNCTION NAME:
 * dataClear
 *
 * INVOCATION:
 * dataClear (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Clear the data buffer
 *
 * DESCRIPTION:
 * This routine resets all the data buffer structure counters but keeps
 * the buffer allocated.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
void dataClear (struct dataBuffer *dat)
{
#if DEBUG_DATABUF
	errlogPrintf ("dataClear: dat=%x\n", dat);
#endif
	dat->index  = 0;
	dat->count  = 0;
}

/*
 *+
 * FUNCTION NAME:
 * dataErase
 *
 * INVOCATION:
 * dataErase (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Erase the data buffer
 *
 * DESCRIPTION:
 * This routine fills the all the allocated buffer with zeroes. It is
 * provided for completeness and is used mostly for testing purposes.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
void dataErase (struct dataBuffer *dat)
{
	int		n;
	struct dataPair	*ptr;

#if DEBUG_DATABUF
	errlogPrintf ("dataErase: dat=%x\n", dat);
#endif
	if (dat->buffer != NULL) {
	    for (n = 0; n < dat->size; n++) {
		ptr = dat->buffer + n;
		ptr->x = 0.0;
		ptr->y = 0.0;
	    }
	}
}

/*
 *+
 * FUNCTION NAME:
 * dataEnter
 *
 * INVOCATION:
 * dataEnter (dat, val)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * (>) val (double)			value to enter into the buffer
 * 
 * FUNCTION VALUE:
 * (int)	OK		ok
 *		ERROR		buffer not allocated
 *
 * PURPOSE:
 * Enter data value into data buffer
 *
 * DESCRIPTION:
 * This routine enters a data value into the data buffer. This is a circular
 * buffer where up to a certain number of data points can be stored.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * dataAlloc
 *
 * DEFICIENCIES:
 * None
 *-
 */
int dataEnter (struct dataBuffer *dat, double x, double y)
{
	struct dataPair	*ptr;

#if DEBUG_DATABUF
	errlogPrintf ("dataEnter: dat=%x, x=%g, y=%g\n", dat, x, y);
#endif

	if (dat->size == 0 || dat->buffer == NULL)
	    return (ERROR);

	ptr = (dat->buffer + dat->index);
	(*ptr).x = x;
	(*ptr).y = y;
	dat->index = (dat->index + 1) % dat->size;
	dat->count = (dat->count < dat->size) ? dat->count + 1 : dat->size;

	return (OK);
}

/*
 *+
 * FUNCTION NAME:
 * dataNpts
 *
 * INVOCATION:
 * dataNpts (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * 
 * FUNCTION VALUE:
 * (int)	number of data points in buffer
 *
 * PURPOSE:
 * Return the number of data values stored into the data buffer
 *
 * DESCRIPTION:
 * This routine returns the number of data points stored in the data buffer,
 * which is less or equal to the buffer size.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
int dataNpts (struct dataBuffer *dat)
{
#if DEBUG_DATABUF
	errlogPrintf ("dataNpts: dat=%x, count=%d\n", dat, dat->count);
#endif
    	return (dat->count);
}

/*
 *+
 * FUNCTION NAME:
 * dataSize
 *
 * INVOCATION:
 * dataSize (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * 
 * FUNCTION VALUE:
 * (int)	total number of data points allocated in buffer
 *
 * PURPOSE:
 * Return the data buffer size in data pairs
 *
 * DESCRIPTION:
 * This routine returns the number of data points allocated in the buffer
 * when dataAlloc was called.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
int dataSize (struct dataBuffer *dat)
{
#if DEBUG_DATABUF
	errlogPrintf ("dataSize: dat=%x, size=%d\n", dat, dat->size);
#endif
    	return (dat->size);
}

/*
 *+
 * FUNCTION NAME:
 * dataStat
 *
 * INVOCATION:
 * dataStat (dat, xmin, avg, sigma)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * (>) xmin (double)			X coordinate of last point
 * (<) avg (double *)			average value
 * (<) sigma (double *)			standard deviation
 * 
 * FUNCTION VALUE:
 * (int)		number of points found above xmin
 *
 * PURPOSE:
 * Calculate data buffer statistics
 *
 * DESCRIPTION:
 * This routine calculates the mean value and standard deviation of the
 * data in the buffer. It is assumed that X value in the data is always
 * increasing. Otherwise the average and standard deviation are meaningless.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * dataAlloc, dataEnter
 *
 * DEFICIENCIES:
 * Data should be sorted in X (increasing)
 *-
 */
int dataStat (struct dataBuffer *dat, double xmin, double *avg, double *sigma)
{
	double			sum  = 0.0;
	double			sum2 = 0.0;
	double			x, y, diff;
    	int			n, npts;

#if DEBUG_DATABUF
	errlogPrintf ("dataStat: dat=%x, xmin=%g\n", dat, xmin);
#endif

	/*
	 * Return immediately if there is no data in the data buffer.
	 */
	if (dat->count == 0 || dat->size == 0 || dat->buffer == NULL)
	    return (ERROR);

	/*
	 * Add numbers from the beginning to the buffer to the last
	 * position entered.
	 */
	for (n = dat->index - 1, npts = 0; n >= 0; n--) {
	    x = (*(dat->buffer + n)).x;
	    y = (*(dat->buffer + n)).y;
	    if (x >= xmin) {
		sum  += y;
		sum2 += y * y;
	        npts++;
	    } else
		break;
	}

#if DEBUG_DATABUF
	errlogPrintf ("dataStat, after beginning: npts=%d, sum=%g, sum2=%g\n",
		  npts, sum, sum2);
#endif

	/*
	 * Add the numbers from the end of the buffer to complete
	 * the number of points required (if any).
	 */
	if (dat->count == dat->size) {
	    for (n = dat->size - 1; n >= dat->index; n--) {
		x = (*(dat->buffer + n)).x;
		y = (*(dat->buffer + n)).y;
		if (x >= xmin) {
		    sum  += y;
		    sum2 += y * y;
		    npts++;
		} else
		    break;
	    }
	}

#if DEBUG_DATABUF
	errlogPrintf ("dataStat, after end: npts=%d, sum=%g, sum2=%g\n",
		npts, sum, sum2);
#endif

	/*
	 * Calculate average and standard deviation if at least one data
	 * point was found. Make the standar deviation zero if there are
	 * less than two data points or if the argument to the square root
	 * turns out to be is negative (rounding errors).
	 */
	if (npts > 0) {
	    *avg = sum / npts;
	    diff = sum2 / npts - (*avg) * (*avg);
	    if (npts < 2 || diff < 0)
		*sigma = 0.0;
	    else
		*sigma = sqrt (diff);
#if DEBUG_DATABUF
	    errlogPrintf ("dataStat, return: diff=%g, avg=%g, sigma=%g\n",
		    diff, *avg, *sigma);
#endif
	}

	return (npts);
}

/*
 *+
 * FUNCTION NAME:
 * dataRawDump
 *
 * INVOCATION:
 * dataRawDump (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Dump contents of data buffer as it is
 *
 * DESCRIPTION:
 * This routine prints the strcuture fields and the contents of the data
 * buffer to the console. It's intended for debugging only.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
void dataRawDump (struct dataBuffer *dat)
{
    	int		n;
	struct dataPair	*ptr;

	errlogPrintf ("dataRawDump: dat=%p\n",  dat);
	if (dat == NULL)
	    return;

	errlogPrintf ("index=%d, count=%d, size=%d, buffer=%p\n",
		dat->index, dat->count, dat->size, dat->buffer);

	if (dat->buffer == NULL)
	    return;

	for (n = 0; n < dat->size; n++) {
	    ptr = (dat->buffer + n);
	    errlogPrintf ("%d: %g, %g\n", n, (*ptr).x, (*ptr).y);
	}
}


/*
 *+
 * FUNCTION NAME:
 * dataDump
 *
 * INVOCATION:
 * dataDump (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Dump contents of data of used part of the buffer
 *
 * DESCRIPTION:
 * This routine prints the strcuture fields and the contents of the data
 * buffer to the console. Only the used part of the buffer is printed.
 * Also, the data is printed from the oldest to the newset entry.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
void dataDump (struct dataBuffer *dat)
{
	errlogPrintf ("dataDump: dat=%p\n", dat);
	if (dat == NULL)
	    return;

	errlogPrintf ("index=%d, count=%d, size=%d, buffer=%p\n",
		dat->index, dat->count, dat->size, dat->buffer);

	dataFpDump (dat, stdout);
}

/*
 *+
 * FUNCTION NAME:
 * dataFileDump
 *
 * INVOCATION:
 * dataFileDump (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * (>) fname (char *)			file name
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Dump contents of data of used part of the buffer to a file
 *
 * DESCRIPTION:
 * This routine is the same as dataDump, but it prints to a file instead
 * of the console.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
int dataFileDump (struct dataBuffer *dat, char *fname)
{
	FILE	*fp;

	if ((fp = fopen (fname, "w")) == NULL) {
	    return (ERROR);
	} else {
	    dataFpDump (dat, fp);
	    return (OK);
	}
}

/*
 *+
 * FUNCTION NAME:
 * dataFpDump
 *
 * INVOCATION:
 * dataFpDump (dat)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) dat (struct dataBuffer *)	pointer to data buffer structure
 * (>) fp (FILE *)			file pointer
 * 
 * FUNCTION VALUE:
 * None
 *
 * PURPOSE:
 * Dump contents of data of used part of the buffer to a file
 *
 * DESCRIPTION:
 * This routine is the one that does the actual work of printing the
 * buffer and it's called by both dataDump and dataFileDump with the
 * appropiate file descriptor.
 *
 * EXTERNAL VARIABLES
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * None
 *-
 */
LOCAL void dataFpDump (struct dataBuffer *dat, FILE *fp)
{
	int	n, npts;
	double	x, y;

	if (dat->count < dat->size) {
	    for (n = 0, npts = 0; n < dat->index; n++, npts++) {
		x = (*(dat->buffer + n)).x;
		y = (*(dat->buffer + n)).y;
		fprintf (fp, "%g %g\n", x, y);
	    }
	} else {
	    for (n = dat->index; n < dat->count; n++) {
		x = (*(dat->buffer + n)).x;
		y = (*(dat->buffer + n)).y;
		fprintf (fp, "%g %g\n", x, y);
	    }
	    for (n = 0; n < dat->index; n++) {
		x = (*(dat->buffer + n)).x;
		y = (*(dat->buffer + n)).y;
		fprintf (fp, "%g %g\n", x, y);
	    }
	}
	if ((fp != stdout) && (fp != stderr))
	    fclose (fp);
}
