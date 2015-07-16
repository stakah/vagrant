#!/bin/sh

# provision.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# esb 
esb=wso2esb
esbv=4.8.1
esbversion=$esb-$esbv
esbzip=$esbversion.zip
esbd="WSO2 Enterprise Service Bus $esbv"

# Carbon config
CARBON_CONF=/opt/$esb/repository/conf/carbon.xml
OFFSET="2"

echo .
echo installing unzip 
sudo apt-get install unzip

echo .
echo Copying $esbd compacted file ...
cp -f /vagrant/$esbzip $DEST

echo .
ls $DEST/*.zip

echo .
echo Unzipping $esbzip
cd $DEST
unzip -o -q $esbzip

echo .
echo Removing $esbzip
rm -f $esbzip

echo .
echo moving $esbversion folder to /opt
rm -rf /opt/$esbversion
mv -f $esbversion /opt
ls -lahd /opt/$esbversion

echo .
echo chown to vagrant
chown -R vagrant:vagrant /opt/$esbversion
ls -lahd /opt/$esbversion

echo .
echo sym-linking to $esbversion
ln -s /opt/$esbversion /opt/$esb
ls -lah /opt/$esb

echo .
echo Backing-up carbon.xml
cp $CARBON_CONF $CARBON_CONF.bkp

echo .
echo Changing $esbd Port offset to $OFFSET
sed -i "s|\(<Offset>\)[^<>]*\(</Offset>\)|\1${OFFSET}\2|" $CARBON_CONF
