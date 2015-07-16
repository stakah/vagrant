#!/bin/sh

# provision.sh

echo provison.sh

# Destination folder
DEST=/home/vagrant

# api manager
am=wso2am
amversion=$am-1.8.0
amzip=$amversion.zip

# esb 
esb=wso2esb
esbversion=$esb-4.8.1
esbzip=$esbversion.zip

echo .
echo installing unzip 
sudo apt-get install unzip

echo .
echo Copying wso2 api manager 1.8.0 compacted file ...
cp -f /vagrant/$amzip $DEST

echo .
echo Copying wso2 enterprise service bus 4.8.1 compacted file ...
cp -f /vagrant/$esbzip $DEST

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
ln -s /opt/$amversion $am
ls -lah /opt/$am
