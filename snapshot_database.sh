#!/usb/bin/env bash

INFLUXD_PATH="/root/influxdb-1.3.4-1/usr/bin/influxd"

DATABASE_NAME="pidiou"

function display_usage() {
    echo "usage: ./snapshot_database.sh <backup_path>"
}

if [ "$1" == "" ]; then
    display_usage
    exit 0
fi
BACKUP_PATH="$1"

echo -n "I will backup the database '${DATABASE_NAME}' in ${BACKUP_PATH} "
OUTPUT=$($INFLUXD_PATH backup -database ${DATABASE_NAME} ${BACKUP_PATH} 2>&1)
echo "[OK]"
echo "+----------------------------------------------------"
echo "$OUTPUT" | sed -e 's/^/| /'
echo "+----------------------------------------------------"

exit 0
