/*
 * Copyright 1996 Association of Universities for Research in Astronomy, Inc.
 * See the file COPYRIGHT for more details.
 *
 * FILENAME
 * gwsSir.c
 *
 * FUNCTION NAME(S)
 * Subroutine		- Brief description
 *
 *INDENT-OFF*
 * $Log: gwsSir.c,v $
 * Revision 1.6  2009/07/30 19:00:53  gemvx
 * Modified the database and stateSir to return a STRING state value
 * to match what the TCS expects.
 *
 * Revision 1.5  2009/07/29 17:44:36  gemvx
 * Modified database, C code and dm screen to make the top level health value
 * a STRING instead of LONG. This is required by the TCS.
 *
 * Revision 1.4  2005/09/06 18:15:09  pedro
 * Rewrote metSizeSir()
 *
 * Revision 1.3  2005/02/11 06:44:38  pedro
 * Added metSizeSir routine
 *
 * Revision 1.2  2003/10/23 17:45:04  pedro
 * Added SOAR weather station.
 *
 * Revision 1.1  2002/05/31 19:35:11  pedro
 * Installed V1-0 (first official CVS release).
 *
 *INDENT-ON*
 */

#include "gws.h"
#include <dbFldTypes.h>
#include <sirRecord.h>
#include <epicsExport.h>
#include <registryFunction.h>
#include <iocsh.h> 

/*
 *+
 * FUNCTION NAME:
 * debugSir
 *
 * INVOCATION:
 * debugSir (psir)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psir (struct sirRecord *)	SIR record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always returns zero
 *
 * PURPOSE:
 * Convert debug level code into message
 *
 * DESCRIPTION:
 * This routine converts the debug level code in VAL into the
 * corresponding message.
 *
 * EPICS INPUT FIELDS:
 * (long)	VAL	debug level code
 *
 * EPICS OUTPUT FIELDS:
 * (string)	IMSS	debug level message
 *			INVALID if no match
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
long debugSir (struct sirRecord *psir)
{
	if (*(long *)psir->val == DBG_NONE)
	    strcpy(psir->imss, "NONE");
	else if (*(long *)psir->val == DBG_MIN)
	    strcpy(psir->imss, "MIN");
	else if (*(long *)psir->val == DBG_FULL)
	    strcpy(psir->imss, "FULL");
	else
	    strcpy(psir->imss, "INVALID");

	return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * simSir
 *
 * INVOCATION:
 * simSir (psir)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psir (struct sirRecord *)	SIR record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always returns zero
 *
 * PURPOSE:
 * Convert simulation level code into message
 *
 * DESCRIPTION:
 * This routine converts the simulation level code in VAL into the
 * corresponding message.
 *
 * EPICS INPUT FIELDS:
 * (long)	VAL	simulation level code
 *
 * EPICS OUTPUT FIELDS:
 * (string)	IMSS	simulation level message
 *			INVALID if no match
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
long simSir (struct sirRecord *psir)
{
	if (*(long *)psir->val == SIMM_NONE)
	    strcpy(psir->imss, "NONE");
	else if (*(long *)psir->val == SIMM_VSM)
	    strcpy(psir->imss, "VSM");
	else if (*(long *)psir->val == SIMM_FAST)
	    strcpy(psir->imss, "FAST");
	else if (*(long *)psir->val == SIMM_FULL)
	    strcpy(psir->imss, "FULL");
	else
	    strcpy(psir->imss, "INVALID");

	return (0L);
}
/*
 *+
 * FUNCTION NAME:
 * healthSir
 *
 * INVOCATION:
 * healthSir (psir)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psir (struct sirRecord *)	SIR record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always returns zero
 *
 * PURPOSE:
 * Convert health code into message
 *
 * DESCRIPTION:
 * This routine converts the health code in VAL into the corresponding
 * message. The program can handle STRING or LONG values in the VAL field.
 * The GWS code uses numeric values for the health, but the TCS expects a
 * string in the top level health.
 *
 * EPICS INPUT FIELDS:
 * (string|long)	VAL	health level code
 *
 * EPICS OUTPUT FIELDS:
 * (string)		IMSS	health level message
 *				INVALID if no match
 *
 * EXTERNAL VARIABLES:
 * None
 *
 * PRIOR REQUIREMENTS:
 * None
 *
 * DEFICIENCIES:
 * It is assumed that VAL will be either STRING or LONG. No error is
 * generated if this is not true.
 *-
 */
long healthSir (struct sirRecord *psir)
{
	int	health;
	char	hstr[40];

	/* Check data type of VAL field and read the value accodingly.
	 */
	if (psir->ftvl == DBF_STRING)
	    health = atoi (psir->val);
	else
	    health = *(long *) psir->val;

	/* Convert (string or long) health code into a readable word.
	 */
	if (health == HEALTH_GOOD)
	    strcpy (hstr, "GOOD");
	else if (health == HEALTH_WARNING)
	    strcpy (hstr, "WARNING");
	else if (health == HEALTH_BAD)
	    strcpy (hstr, "BAD");
	else
	    strcpy (hstr, "INVALID");

	/* Update output fields. The value needs to be updated only when
	 * it's a string because the health code (in string representation)
	 * code needs to be converted into a readable word.
	 */
	if (psir->ftvl == DBF_STRING)
	    strcpy (psir->val, hstr);
	strcpy (psir->imss, hstr);

	return(0L);
}


/*
 *+
 * FUNCTION NAME:
 * stateSir
 *
 * INVOCATION:
 * stateSir (psir)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psir (struct sirRecord *)	SIR record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always returns zero
 *
 * PURPOSE:
 * Convert state code into message
 *
 * DESCRIPTION:
 * This routine converts the state code in VAL into the corresponding
 * message.
 *
 * EPICS INPUT FIELDS:
 * (long)	VAL	state level code
 *
 * EPICS OUTPUT FIELDS:
 * (string)	IMSS	state level message
 *			INVALID if no match
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
long stateSir (struct sirRecord *psir)
{
	long	state;
	char	str[40];

	state = atoi (psir->val);

	if (state == BOOTING)
	    strcpy(str, "BOOTING");
	else if (state == INITIALISING)
	    strcpy(str, "INITIALISING");
	else if (state == RUNNING)
	    strcpy (str, "RUNNING");
	else
	    strcpy(str, "INVALID");

	/* Update output fields.
	 */
	strcpy (psir->val,  str);
	strcpy (psir->imss, str);

	return(0L);
}

/*
 *+
 * FUNCTION NAME:
 * wsSelSir
 *
 * INVOCATION:
 * wsSelSir (psir)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psir (struct sirRecord *)	SIR record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always returns zero
 *
 * PURPOSE:
 * Convert weather station number into a name
 *
 * DESCRIPTION:
 * This routine converts the weather station number in VAL into the
 * corresponding message.
 *
 * EPICS INPUT FIELDS:
 * (long)	VAL	weather station number
 *
 * EPICS OUTPUT FIELDS:
 * (string)	IMSS	weather station message
 *			INVALID if no match
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
long wsSelSir (struct sirRecord *psir)
{
	if (*(long *)psir->val == WS_PACHON)
	    strcpy(psir->imss, "PACHON");
	else if (*(long *)psir->val == WS_SOAR)
	    strcpy(psir->imss, "SOAR");
	else if (*(long *)psir->val == WS_CTIO)
	    strcpy(psir->imss, "CTIO");
	else if (*(long *)psir->val == WS_CFHT)
	    strcpy(psir->imss, "CFHT");
	else if (*(long *)psir->val == WS_UKIRT)
	    strcpy(psir->imss, "UKIRT");
	else
	    strcpy(psir->imss, "INVALID");

	return (0L);
}

/*
 *+
 * FUNCTION NAME:
 * metSizeSir
 *
 * INVOCATION:
 * metSizeSir (psir)
 *
 * PARAMETERS: (">" input, "!" modified, "<" output)
 * (>) psir (struct sirRecord *)	SIR record pointer
 * 
 * FUNCTION VALUE:
 * (long)       always returns zero
 *
 * PURPOSE:
 * Convert particle size index into a text
 *
 * DESCRIPTION:
 * This routine converts the ...
 *
 * EPICS INPUT FIELDS:
 * (long)	VAL	particle size index
 *
 * EPICS OUTPUT FIELDS:
 * (string)	IMSS	particle size text
 *			INVALID if no match
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
#if 0
long metSizeSir (struct sirRecord *psir)
{
	if (*(long *)psir->val == MET_0_5)
	    strcpy(psir->imss, "0.5 micron");
	else if (*(long *)psir->val == MET_1_0)
	    strcpy(psir->imss, "1.0 micron");
	else if (*(long *)psir->val == MET_2_0)
	    strcpy(psir->imss, "2.0 micron");
	else if (*(long *)psir->val == MET_3_0)
	    strcpy(psir->imss, "3.0 micron");
	else
	    strcpy(psir->imss, "INVALID");

	return (0L);
}
#endif

long metSizeSir (struct sirRecord *psir)
{
	if (strcmp ((char *)psir->val,      "1") == 0)
	    strcpy(psir->imss, "0.5 microns");
	else if (strcmp ((char *)psir->val, "2") == 0)
	    strcpy(psir->imss, "1.0 micron");
	else if (strcmp ((char *)psir->val, "3") == 0)
	    strcpy(psir->imss, "2.0 microns");
	else if (strcmp ((char *)psir->val, "4") == 0)
	    strcpy(psir->imss, "3.0 microns");
	else
	    strcpy(psir->imss, "INVALID");

	return (0L);
}

long metTimeSir (struct sirRecord *psir)
{
	sprintf (psir->imss, "%s seconds", (char *) psir->val);
	return (0L);
}
epicsRegisterFunction(debugSir);
epicsRegisterFunction(healthSir);
epicsRegisterFunction(stateSir);
epicsRegisterFunction(simSir);
epicsRegisterFunction(metSizeSir);
epicsRegisterFunction(wsSelSir);
