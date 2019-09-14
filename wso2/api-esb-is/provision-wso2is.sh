#!/bin/sh

# provision.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# api manager
is=wso2is
isv=5.0.0
isversion=$is-$isv
iszip=$isversion-patched.zip
isd="WSO2 Identity Servervagrant $isv"

startup=startup-is.sh

# Carbon config
CARBON_CONF=/opt/$is/repository/conf/carbon.xml
OFFSET="0"

echo .
echo installing unzip 
sudo apt-get install unzip

echo .
echo Copying $isd compacted file ...
cp -f /vagrant/$iszip $DEST

echo .
ls $DEST/*.zip

echo .
echo Unzipping $iszip
cd $DEST
unzip -o -q $iszip

echo .
echo Removing $iszip
rm -f $iszip

echo .
echo moving $isversion folder to /opt
rm -rf /opt/$isversion
mv -f $isversion /opt
ls -lahd /opt/$isversion

echo .
echo chown to vagrant
chown -R vagrant:vagrant /opt/$isversion
ls -lahd /opt/$isversion

echo .
echo sym-linking to $isversion
ln -s /opt/$isversion /opt/$is
ls -lah /opt/$is

echo .
echo Backing-up carbon.xml
cp $CARBON_CONF $CARBON_CONF.bkp

echo .
echo Changing $isd Port offset to $OFFSET
sed -i "s|\(<Offset>\)[^<>]*\(</Offset>\)|\1${OFFSET}\2|" $CARBON_CONF

echo .
echo Creating $startup script
echo Use: sh ./$startup
cp -f /vagrant/$startup $DEST/$startup

echo .
echo chmod +x on $startup
chmod a+x $DEST/$startup
