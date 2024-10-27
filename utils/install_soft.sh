#!/usr/bin/env bash

if [ $(id -u) -ne 0 ]
  then echo "Please run this script as root or using sudo!"
  exit
fi

set -e

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
dq11DIR="$(dirname "$SCRIPTPATH")"
A3818_DRIVERDIR=$dq11DIR/soft/A3818Drv-1.6.8/
CAENHVWrapper_RDIR=$dq11DIR/soft/CAENHVWrapper-6.3/

# Install drivers
echo "Installing drivers for A3818 board..."
cd $A3818_DRIVERDIR
make
make install
echo "Installation of the drivers for A3818 board is completed."

echo "Installing CAENHVWrapper..."
cd $CAENHVWrapper_RDIR
./install.sh 
echo "Installation of CAENHVWrapper is completed."

# Building and seting up docker containers
echo "Building and seting up docker containers (takes about 10-15 minutes)..."
cd $dq11DIR
docker compose up --build -d
echo "Everything seems to be done!"