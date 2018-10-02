#!/bin/sh

# provision-jdk.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# jdk
jdk="jdk"
jdkmainv="8"
jdkupdatev="181"
jdkv="${jdkmainv}u${jdkupdatev}"
jdkrelease="${jdkv}-b13"
jdkhash="96a7b8442fe848ef90c96a2fad6ed6d1"
jdkos="linux"
jdkarc="x64"
jdkversion="${jdk}-${jdkv}-${jdkos}-${jdkarc}"
jdkzip="${jdkversion}.tar.gz"
jdkfolder="jdk1.${jdkmainv}.0_${jdkupdatev}"

# http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz

if [ -f /vagrant/$jdkzip ]; then 
    echo Copying $jdkversion
    cp -f /vagrant/$jdkzip $DEST
else
	echo Downloading $jdkzip
    wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/$jdkrelease/$jdkhash/$jdkzip
    cp $jdkzip /vagrant
fi

echo Uncompressing $jdkzip
tar -xf $jdkzip

echo Moving $jdkfolder folder to /usr/java
mkdir -p /usr/java
rm -rf /usr/java/$jdkfolder
mv -f $jdkfolder /usr/java

echo Removing $jdkzip
rm -f $jdkzip

echo Setting up JAVA_HOME for vagrant user
echo "" >> /home/vagrant/.profile
echo export JAVA_HOME=/usr/java/$jdkfolder >> /home/vagrant/.profile
echo PATH=\$PATH:\$JAVA_HOME/bin >> /home/vagrant/.profile

echo exporting JAVA_HOME
export JAVA_HOME=/usr/java/$jdkfolder
echo "JAVA_HOME=$JAVA_HOME"
