#!/bin/sh

# provision.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

startup=startup.sh
shutdown=shutdown.sh

echo .
echo Creating $startup script
echo Use: sh ./$startup
cp -f /vagrant/$startup $DEST/$startup

echo .
echo chmod +x on $startup
chmod a+x $DEST/$startup

echo .
echo Creating $shutdown script
echo Use: sh ./$shutdown
cp -f /vagrant/$shutdown $DEST/$shutdown

echo .
echo chmod +x on $shutdown
chmod a+x $DEST/$shutdown
