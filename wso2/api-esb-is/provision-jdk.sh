#!/bin/sh

# provision-jdk.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# jdk
jdk="jdk"
jdkv="7u79"
jdkrelease="${jdkv}-b15"
jdkos="linux"
jdkarc="x64"
jdkversion="${jdk}-${jdkv}-${jdkos}-${jdkarc}"
jdkzip="${jdkversion}.tar.gz"
jdkfolder="jdk1.7.0_79"


if [ -f /vagrant/$jdkzip ]; then 
    echo .
    echo Copying $jdkversion
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
