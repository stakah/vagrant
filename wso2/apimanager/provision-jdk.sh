#!/bin/sh

# provision-jdk.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# jdk
jdk="jdk"
jdkv="7u80"
jdkrelease="${jdkv}-b15"
jdkos="linux"
jdkarc="x64"
jdkversion="${jdk}-${jdkv}-${jdkos}-${jdkarc}"
jdkzip="${jdkversion}.tar.gz"
jdkfolder="jdk1.7.0_80"
jce="UnlimitedJCEPolicy"
jcezip="${jce}JDK7.zip"

#http://download.oracle.com/otn-pub/java/jdk/7u80-b15-demos/jdk-7u80-linux-x64-demos.tar.gz?AuthParam=1464976408_ee114baed3ca269e4a1519161b48c4f7
#http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz?AuthParam=1464975611_084140b97bd5dc283b1e49bb76dafce

echo "Installing unzip"
sudo apt-get update
sudo apt-get install unzip -y

if [ -f /vagrant/$jdkzip ]; then 
    echo Copying $jdkversion
    cp -f /vagrant/$jdkzip $DEST
else
	echo Downloading $jdkzip
    wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/$jdkrelease/$jdkzip
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

echo exporting JAVA_HOME
export JAVA_HOME=/usr/java/$jdkfolder
echo "JAVA_HOME=$JAVA_HOME"

echo Copying $jcezip
cp -f /vagrant/$jcezip $DEST

echo Uncompressing $jcezip
unzip -o -q $jcezip

echo Backing up local_policy.jar and US_export_policy.jar
mv $JAVA_HOME/jre/lib/security/local_policy.jar     $JAVA_HOME/jre/lib/security/local_policy.jar.bkp
mv $JAVA_HOME/jre/lib/security/US_export_policy.jar $JAVA_HOME/jre/lib/security/US_export_policy.jar.bkp

echo Copying Unlimited Strengh policies
cp $DEST/$jce/local_policy.jar     $JAVA_HOME/jre/lib/security/
cp $DEST/$jce/US_export_policy.jar $JAVA_HOME/jre/lib/security/
