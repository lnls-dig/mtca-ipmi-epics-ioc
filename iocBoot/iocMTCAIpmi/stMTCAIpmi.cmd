# Startup script for MTCA crate monitoring IOC
< envPaths

epicsEnvSet("TOP","../..")
epicsEnvSet("CRATE", "DIG:MCH_TEST:")
epicsEnvSet("MCH_HOST", "10.2.118.35")
epicsEnvSet("CRATE_ID", "MTCA RSV")
epicsEnvSet("RACK_ID", "Dev net")

< MTCAIpmi.config

## Register all support components
dbLoadDatabase "dbd/mtcaSensors.dbd"
mtcaSensors_registerRecordDeviceDriver pdbbase

## Load record instances
# Set CU1, CU2 environment variables to override default cooling unit names.
# Set PM environment variables to override default power module name.
dbLoadRecords("db/mtca_crate.db","P=$(CRATE),MCH_HOST=$(MCH_HOST),CRATE_ID=$(CRATE_ID),RACK_ID=$(RACK_ID),CU1=$(CU1=CU01),CU2=$(CU2=CU02)")
dbLoadRecords("db/amc_cards.db","P=$(CRATE),PM=$(PM=PM02)")
dbLoadRecords("db/cooling_unit.template","P=$(CRATE),S=$(CU1=CU01),UNIT=1")
dbLoadRecords("db/cooling_unit.template","P=$(CRATE),S=$(CU2=CU02),UNIT=2")
dbLoadRecords("db/power_modules.db","P=$(CRATE)")
dbLoadRecords("db/mch.db","P=$(CRATE),PM=$(PM=PM02)")

iocInit()

# This IOC can take >20 s to exit. Please be patient.
