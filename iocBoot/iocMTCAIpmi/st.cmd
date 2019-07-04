#!../../bin/linux-x86_64/mtcaSensors

## You may have to change mtcaSensors to something else
## everywhere it appears in this file

epicsEnvSet("CRATE", "DIG:MCH_TEST:")
epicsEnvSet("MCH_HOST", "10.2.118.35")
epicsEnvSet("CRATE_ID", "MTCA RSV")
epicsEnvSet("RACK_ID", "Dev net")

< envPaths

< $(TOP)/iocBoot/ioc-mtca-common/st_mtca_common.cmd

