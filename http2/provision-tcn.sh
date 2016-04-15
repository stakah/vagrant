#!/bin/sh

# Provision Tomcat Native

echo ${0}

#http://ftp.unicamp.br/pub/apache/tomcat/tomcat-connectors/native/1.2.5/source/tomcat-native-1.2.5-src.tar.gz ### Está com bug
#https://archive.apache.org/dist/tomcat/tomcat-connectors/native/1.2.2/source/tomcat-native-1.2.2-src.tar.gz
#http://mirror.nbtelecom.com.br/apache/tomcat/tomcat-connectors/native/1.1.34/source/  ## Incompativel@

TCN="tomcat-native"
TCN_MAJOR_V="1"
TCN_MINOR_V="2"
TCN_REV="2"

TCN_V=${TCN_MAJOR_V}.${TCN_MINOR_V}.${TCN_REV}
TCN_VERSION=$TCN-$TCN_V
TCN_SRC_FOLDER=$TCN_VERSION-src
TCN_GZ=$TCN_VERSION-src.tar.gz
TCN_DESCRIPTION="Apache Tomcat Native Library $TCN_V"
TCN_DOWNLOAD_URL="https://archive.apache.org/dist/tomcat/tomcat-connectors/native/${TCN_V}/source/${TCN_GZ}"

# Home folder
HOME=/home/vagrant

echo sourcing $HOME/.profile
. $HOME/.profile

echo JAVA_HOME=$JAVA_HOME

echo "installing libssl-dev, subversion, autoconf"
sudo apt-get update
sudo apt-get install libssl-dev -y
#sudo apt-get install libssl-dev subversion autoconf -y
#sudo apt-get install ant

# Destination folder
DEST=/home/vagrant

if [ -f /vagrant/$TCN_GZ ]; then 
    echo .
    echo Copying $TCN_VERSION
    cp -f /vagrant/$TCN_GZ $DEST
else
	echo .
	echo Downloading $TCN_GZ
    wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  $TCN_DOWNLOAD_URL
    cp $TCN_GZ /vagrant
fi

echo .
ls $DEST/*.tar.gz

echo .
echo Uncompressing $TCN_GZ
tar -xf $TCN_GZ

#echo .
#echo Checkin-out source from Subversion
#mkdir $TCN_SRC_FOLDER
#cd $TCN_SRC_FOLDER
#svn co https://svn.apache.org/repos/asf/tomcat/native/trunk/

# Building $TCN_VERSION
APR="/usr/local/apr/bin/apr-1-config"
OPENSSL="/usr/include/openssl"
#cd trunk/native
cd $TCN_SRC_FOLDER/native
#autoconf configure.in > configure
#chmod u+x configure
#sh buildconf --with-apr=$APR_SRC
./configure --with-apr=$APR \
            --with-java-home=$JAVA_HOME \
            --with-ssl=$OPENSSL \
            --prefix=$CATALINA_HOME
make
sudo make install
