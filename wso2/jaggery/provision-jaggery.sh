#!/bin/sh

# provision.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# jaggery
am=jaggery
amv=0.9.0
amversion=$am-$amv-SNAPSHOT
amzip=${amversion}_ALPHA3.zip
amd="jaggery.js $amv"
ams="jaggeryd"

# Carbon config
JAGGERY_HOME=/opt/$am
CARBON_HOME=$JAGGERY_HOME/carbon
#CARBON_CONF=$CARBON_HOME/repository/conf/carbon.xml
#OFFSET="1"

echo sourcing $DEST/.profile
. $DEST/.profile

echo JAVA_HOME=$JAVA_HOME

echo installing unzip 
sudo apt-get install unzip

echo Copying $amd compacted file ...
cp -f /vagrant/$amzip $DEST

ls $DEST/*.zip

echo Unzipping $amzip
cd $DEST
unzip -o -q $amzip

echo Removing $amzip
rm -f $amzip

echo moving $amversion folder to /opt
rm -rf /opt/$amversion
mv -f $amversion /opt
ls -lahd /opt/$amversion

echo Chmoding wso2server.sh
sudo chmod a+x $CARBON_HOME/bin/wso2server.sh

echo chown to vagrant
sudo chown -R vagrant:vagrant /opt/$amversion
ls -lahd /opt/$amversion

echo sym-linking to $amversion
ln -s /opt/$amversion $JAGGERY_HOME
ls -lah $JAGGERY_HOME


#echo Backing-up carbon.xml
#cp $CARBON_CONF $CARBON_CONF.bkp

#echo Changing $amd Port offset to $OFFSET
#sed -i "s|\(<Offset>\)[^<>]*\(</Offset>\)|\1${OFFSET}\2|" $CARBON_CONF

sh /opt/$amversion/bin/server.sh &
