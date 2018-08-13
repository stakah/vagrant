#!/bin/sh

# provision-jdk.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

#http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz
# jdk
jdk="jdk"
jdkmajorv="8"
jdkminorv="0"
jdkupdate="77"
jdkv="${jdkmajorv}u${jdkupdate}"
jdkversion="1.${jdkmajorv}.${jdkminorv}"
jdkrelease="${jdkv}-b03"
jdkos="linux"
jdkarc="x64"
jdkzip="${jdk}-${jdkv}-${jdkos}-${jdkarc}.tar.gz"
jdkfolder="${jdk}${jdkversion}_${jdkupdate}"


if [ -f /vagrant/$jdkzip ]; then 
    echo .
    echo Copying $jdkzip
    cp -f /vagrant/$jdkzip $DEST
else
	echo .
	echo Downloading $jdkzip
    wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/$jdkrelease/$jdkzip
    cp $jdkzip /vagrant
fi

echo .
echo Uncompressing $jdkzip
tar -xf $jdkzip

echo .
echo Moving $jdkfolder folder to /usr/java
mkdir -p /usr/java
rm -rf /usr/java/$jdkfolder
mv -f $jdkfolder /usr/java

echo .
echo Removing $jdkzip
rm -f $jdkzip

echo .
echo Setting up JAVA_HOME for vagrant user
echo "" >> /home/vagrant/.profile
echo export JAVA_HOME=/usr/java/$jdkfolder >> /home/vagrant/.profile
