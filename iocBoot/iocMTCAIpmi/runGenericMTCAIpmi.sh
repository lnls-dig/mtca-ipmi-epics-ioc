#!/bin/sh

set -e
set +u

# Source environment
. ./checkEnv.sh

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Check last command return status
if [ $? -ne 0 ]; then
	echo "Could not parse command-line options" >&2
	exit 1
fi

if [ -z "$IPADDR" ]; then
    echo "IP address not set. Please use -i option or set \$IPADDR environment variable" >&2
    exit 3
fi

if [ -z "$CRATE_ID" ]; then
    echo "Crate ID not set. Please use -c option or set \$CRATE_ID environment variable" >&2
    exit 4
fi

if [ -z "$RACK_ID" ]; then
    echo "Rack ID not set. Please use -r option or set \$RACK_ID environment variable" >&2
    exit 5
fi

if [ -z "$DEVICE_TYPE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 6
fi

if [ -z "$EPICS_CA_MAX_ARRAY_BYTES" ]; then
    EPICS_CA_MAX_ARRAY_BYTES="10000000"
fi

MTCA_IPMI_TYPE=$(echo ${DEVICE_TYPE} | grep -Eo "[^0-9]+");

if [ -z "$MTCA_IPMI_TYPE" ]; then
    echo "MTCA_IPMI device type is not valid. Please check the -d option" >&2
    exit 7
fi

case ${MTCA_IPMI_TYPE} in
    CRATE)
        ST_CMD_FILE=stMTCACrate12.cmd
        ;;

    *)
        echo "Invalid MTCA_IPMI type: "${MTCA_IPMI_TYPE} >&2
        exit 7
        ;;
esac

echo "Using st.cmd file: "${ST_CMD_FILE}

cd "$IOC_BOOT_DIR"

EPICS_CA_MAX_ARRAY_BYTES="$EPICS_CA_MAX_ARRAY_BYTES" MCH_HOST="$IPADDR" P="${P}" R="${R}" CRATE_ID="$CRATE_ID" RACK_ID="$RACK_ID" "$IOC_BIN" "$ST_CMD_FILE"
