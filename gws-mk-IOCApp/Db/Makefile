TOP=../..
include $(TOP)/configure/CONFIG

#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

# Search for .db files in $SYS_DB_PATHS, the list 
# of paths output by "convertGemRelease.pl dbPaths"
vpath %.db $(SYS_DB_PATHS)
vpath %.proto $(SYS_DB_PATHS)

#----------------------------------------------------
# Create and install (or just install) into <top>/db
# databases, templates, substitutions like this
# DB += xxx.db
DEPSCHS = $(wildcard ../*.sch)
DB += gwsTop.db 
DB += gwsSadTop.db 

DB_INSTALLS += UKIRT.proto
DB_INSTALLS += CFHT.proto
#DB_INSTALLS += monDimm.proto
#DB_INSTALLS += monMass.proto
DB_INSTALLS += wsDhg.proto
DB_INSTALLS += wsYng.proto
#DB_INSTALLS += wsQualStation.proto
DB_INSTALLS += wsVaisLog.proto
DB_INSTALLS += wsVaisHum.proto
DB_INSTALLS += wsPartMon.proto

DB_INSTALLS += iocAdminSoft.db
DB_INSTALLS += asynRecord.db

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
$(COMMON_DIR)/%.db: %.db
	cp $< $@

clean::
	$(RM) *.bak *.dat
