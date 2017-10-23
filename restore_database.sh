#!/usb/bin/env bash

INFLUXD_PATH="/root/influxdb-1.3.4-1/usr/bin/influxd"

INFLUXDB_METADIR="/root/.influxdb/meta"
INFLUXDB_DATADIR="/root/.influxdb/data"

DATABASE_NAME="pidiou"

function display_usage() {
    echo "usage: ./restore_database.sh <backup_path>"
}

if [ "$1" == "" ]; then
    display_usage
    exit 0
fi
BACKUP_PATH="$1"

echo "I will restore the database '${DATABASE_NAME}' in ${BACKUP_PATH}"

# Restoring metastore
echo -n "  - restoring metastore "
OUTPUT=$($INFLUXD_PATH restore -metadir ${INFLUXDB_METADIR} ${BACKUP_PATH})
echo "[OK]"
echo "+----------------------------------------------------"
echo "$OUTPUT" | sed -e 's/^/| /'
echo "+----------------------------------------------------"

# Restoring datastore
echo -n "  - restoring datastore "
OUTPUT=$($INFLUXD_PATH restore -database ${DATABASE_NAME} -datadir ${INFLUXDB_DATADIR} ${BACKUP_PATH})
echo "[OK]"
echo "+----------------------------------------------------"
echo "$OUTPUT" | sed -e 's/^/| /'
echo "+----------------------------------------------------"

exit 0
