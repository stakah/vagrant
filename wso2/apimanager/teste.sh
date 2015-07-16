#!/bin/sh

# jdk
jdk="jdk"
jdkv="7u79"
jdkrelease="${jdkv}-b15"
jdkos="linux"
jdkarc="x64"
jdkversion="${jdk}-${jdkv}-${jdkos}-${jdkarc}"
jdkzip="${jdkversion}.tar.gz"
jdkfolder="jdk1.7.0_79"

echo jdk=$jdk
echo jdkv=$jdkv
echo jdkos=$jdkos
echo jdkarc=$jdkarc
echo "jdkversion=${jdkversion}"
echo jdkzip=$jdkzip


if [ -f /vagrant/$jdkzip ]; then 
    echo .
    echo Copying $jdkversion
    cp -f /vagrant/$jdkzip $DEST
else
	echo .
	echo Downloading $jdkzip
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/$jdkrelease/$jdkzip
    cp $jdkzip /vagrant
fi
