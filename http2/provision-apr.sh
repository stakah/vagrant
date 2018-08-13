#!/bin/sh

# Provision APR

echo ${0}

#http://ftp.unicamp.br/pub/apache//apr/apr-1.5.2.tar.gz
APR="apr"
APR_MAJOR_V="1"
APR_MINOR_V="5"
APR_REV="2"

APR_V=${APR_MAJOR_V}.${APR_MINOR_V}.${APR_REV}
APR_VERSION=$APR-$APR_V
APR_GZ=$APR_VERSION.tar.gz
APR_DESCRIPTION="Apache Portable Runtime $APR_V"
APR_DOWNLOAD_URL="http://ftp.unicamp.br/pub/apache/apr/${APR_GZ}"

# Destination folder
DEST=/home/vagrant

if [ -f /vagrant/$APR_GZ ]; then 
    echo .
    echo Copying $APR_VERSION
    cp -f /vagrant/$APR_GZ $DEST
else
	echo .
	echo Downloading $APR_GZ
    wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  $APR_DOWNLOAD_URL
    cp $APR_GZ /vagrant
fi

echo .
ls $DEST/*.tar.gz

echo .
echo Uncompressing $APR_GZ
tar -xf $APR_GZ

# Building $APR_VERSION
cd $APR_VERSION
./configure
make
sudo make install

echo .
echo Setting up APR_SRC for vagrant user
echo "" >> /home/vagrant/.profile
echo export APR_SRC=/home/vagrant/$APR_VERSION >> /home/vagrant/.profile

