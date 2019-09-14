#!/bin/sh

# provision.sh

echo provison.sh

# Destination folder
DEST=/home/vagrant

# api manager
am=wso2am
amv=1.9.0
amversion=$am-$amv
amzip=$amversion.zip
amd="WSO2 API Manager $amv"

startup=startup-am.sh

# Carbon config
CARBON_CONF=/opt/$am/repository/conf/carbon.xml
OFFSET="1"

echo .
echo installing unzip 
sudo apt-get install unzip

echo .
echo Copying $amd compacted file ...
cp -f /vagrant/$amzip $DEST

echo .
ls $DEST/*.zip

echo .
echo Unzipping $amzip
cd $DEST
unzip -o -q $amzip

echo .
echo moving $amversion folder to /opt
rm -rf /opt/$amversion
mv -f $amversion /opt
ls -lahd /opt/$amversion

echo .
echo chown to vagrant
chown -R vagrant:vagrant /opt/$amversion
ls -lahd /opt/$amversion

echo .
echo sym-linking to $amversion
ln -s /opt/$amversion /opt/$am
ls -lah /opt/$am

echo .
echo Backing-up carbon.xml
cp $CARBON_CONF $CARBON_CONF.bkp

echo .
echo Changing $amd Port offset to $OFFSET
sed -i "s|\(<Offset>\)[^<>]*\(</Offset>\)|\1${OFFSET}\2|" $CARBON_CONF

echo .
echo Creating $startup script
echo Use: sh ./$startup
cp -f /vagrant/$startup $DEST/$startup

echo .
echo chmod +x on $startup
chmod a+x $DEST/$startup
