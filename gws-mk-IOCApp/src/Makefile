TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = gws-mk-IOC

# gws-mk-IOC.dbd will be created and installed
DBD += gws-mk-IOC.dbd

# gws-mk-IOC.dbd will be made up from these files:
gws-mk-IOC_DBD += base.dbd
gws-mk-IOC_DBD += devAsynOctet.dbd
gws-mk-IOC_DBD += hb2health.dbd
gws-mk-IOC_DBD += streamApp.dbd
gws-mk-IOC_DBD += asyn.dbd
gws-mk-IOC_DBD += drvAsynIPPort.dbd
gws-mk-IOC_DBD += geminiRecords.dbd
gws-mk-IOC_DBD += gws.dbd
gws-mk-IOC_DBD += pvload.dbd    

# Add all the support libraries used by this IOC
gws-mk-IOC_LIBS += stream
gws-mk-IOC_LIBS += pcre
gws-mk-IOC_LIBS += asyn
gws-mk-IOC_LIBS += geminiRecords
gws-mk-IOC_LIBS += hb2health
gws-mk-IOC_LIBS += pvload        

# gws-mk-IOC_registerRecordDeviceDriver.cpp derives from gws-mk-IOC.dbd
gws-mk-IOC_SRCS += gws-mk-IOC_registerRecordDeviceDriver.cpp

gws-mk-IOC_SRCS += debug.c
gws-mk-IOC_SRCS += gwsCad.c
gws-mk-IOC_SRCS += gwsCommands.c
gws-mk-IOC_SRCS += gwsMisc.c
gws-mk-IOC_SRCS += gwsPrecipitation.c
gws-mk-IOC_SRCS += gwsSir.c
#gws-mk-IOC_SRCS += monDimm.c
#gws-mk-IOC_SRCS += monMass.c
gws-mk-IOC_SRCS += databuf.c
#gws-mk-IOC_SRCS += parser.c
gws-mk-IOC_SRCS += scan.c
gws-mk-IOC_SRCS += wsFilter.c

# Build the main IOC entry point on workstation OSs.
gws-mk-IOC_SRCS_DEFAULT += gws-mk-IOCMain.cpp

# Finally link to the EPICS Base libraries
gws-mk-IOC_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

