#!/usr/bin/env bash

if [ $(id -u) -ne 0 ]
  then echo "Please run this script as root or using sudo!"
  exit
fi

set -e

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
dq11DIR="$(dirname "$SCRIPTPATH")"
A3818DRIVERDIR=$dq11DIR/soft/A3818Drv-1.6.8/
LOGDIR=$dq11DIR/store

# Stop docker
cd $dq11DIR
echo "Stopping docker containers..."
docker compose stop

# Clear old logs
echo "Old logs of the caen_tools will be deleted."
echo "Deleteting..."
printf -v date "%(%Y-%m*)T\n" -1

rm -f $LOGDIR/ws.log.$date
rm -f $LOGDIR/check.log.$date
rm -f $LOGDIR/monitor.log.$date
rm -f $LOGDIR/device.log.$date

echo "Deleteting is completed."

# Reinstall drivers
echo "Reinstalling drivers for A3818 board..."
cd $A3818DRIVERDIR
make uninstall
make
make install
echo "Reinstalling is completed."

# Start docker
echo "Starting docker containers..."
cd $dq11DIR
docker compose up -d
echo "Everything seems to be done!"
