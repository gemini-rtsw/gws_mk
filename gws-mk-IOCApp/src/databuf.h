#ifndef INCDatabufH
#define INCDatabufH

/*
 * Data buffer struture.
 */
struct dataPair {
    double	x, y;
};
struct dataBuffer {
    int			index;		/* next free location */
    int			count;		/* number of items in the buffer */
    int			size;		/* buffer size in chars */
    struct dataPair	*buffer;	/* data buffer */
};

/*
 * Data handling routines.
 */
int	dataAlloc  (struct dataBuffer *, int);
void	dataFree   (struct dataBuffer *);
void	dataClear  (struct dataBuffer *);
void	dataErase  (struct dataBuffer *);

int	dataEnter  (struct dataBuffer *, double, double);

int	dataNpts   (struct dataBuffer *);
int	dataSize   (struct dataBuffer *);

int	dataStat   (struct dataBuffer *, double, double *, double *);

void	dataDump     (struct dataBuffer *);
int	dataFileDump (struct dataBuffer *, char *);

#endif
