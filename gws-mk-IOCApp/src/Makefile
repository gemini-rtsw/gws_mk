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

# Include dbd files from all support modules:
#gws-mk-IOC_DBD += xxx.dbd

# Add all the support libraries used by this IOC
# gws-mk-IOC_LIBS += xxx
# gws-mk-IOC_LIBS += seq pv seqDev

# gws-mk-IOC_registerRecordDeviceDriver.cpp derives from gws-mk-IOC.dbd
gws-mk-IOC_SRCS += gws-mk-IOC_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
gws-mk-IOC_SRCS_DEFAULT += gws-mk-IOCMain.cpp

# Finally link to the EPICS Base libraries
gws-mk-IOC_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

