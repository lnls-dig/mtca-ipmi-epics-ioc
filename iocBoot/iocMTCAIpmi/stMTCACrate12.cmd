# Startup script for MTCA crate monitoring IOC
< envPaths

epicsEnvSet("TOP","../..")

< MTCAIpmi.config

## Register all support components
dbLoadDatabase("${TOP}/dbd/mtcaSensors.dbd",0,0)
mtcaSensors_registerRecordDeviceDriver(pdbbase)

## Load record instances
# Set CU1, CU2 environment variables to override default cooling unit names.
# Set PM environment variables to override default power module name.
dbLoadRecords("${TOP}/db/mtca_crate.db","P=$(CRATE),MCH_HOST=$(MCH_HOST),CRATE_ID=$(CRATE_ID),RACK_ID=$(RACK_ID),CU1=$(CU1=CU01),CU2=$(CU2=CU02)")
dbLoadRecords("${TOP}/db/amc_cards.db","P=$(CRATE),PM=$(PM=PM02)")
dbLoadRecords("${TOP}/db/cooling_unit.template","P=$(CRATE),S=$(CU1=CU01),UNIT=1")
dbLoadRecords("${TOP}/db/cooling_unit.template","P=$(CRATE),S=$(CU2=CU02),UNIT=2")
dbLoadRecords("${TOP}/db/power_modules.db","P=$(CRATE)")
dbLoadRecords("${TOP}/db/mch.db","P=$(CRATE),PM=$(PM=PM02)")

iocInit()

# This IOC can take >20 s to exit. Please be patient.
