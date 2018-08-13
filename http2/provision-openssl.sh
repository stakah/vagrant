#!/bin/sh

# provision openssl 1.0.2

echo ${0}


#wget ftp://ftp.openssl.org/source/openssl-1.0.2.tar.gz
#tar xvzf openssl-1.0.2.tar.gz
#cd openssl-1.0.2/
#./config
#make
#sudo make install



OPENSSL="openssl"
OPENSSL_MAJOR_V="1"
OPENSSL_MINOR_V="0"
OPENSSL_REV="2g"

OPENSSL_V=${OPENSSL_MAJOR_V}.${OPENSSL_MINOR_V}.${OPENSSL_REV}
OPENSSL_VERSION=$OPENSSL-$OPENSSL_V
OPENSSL_GZ=$OPENSSL_VERSION.tar.gz
OPENSSL_DESCRIPTION="$OPENSSL_V"
OPENSSL_DOWNLOAD_URL="ftp://ftp.openssl.org/source/${OPENSSL_GZ}"

# Destination folder
DEST=/home/vagrant

if [ -f /vagrant/$OPENSSL_GZ ]; then 
    echo .
    echo Copying $OPENSSL_VERSION
    cp -f /vagrant/$OPENSSL_GZ $DEST
else
	echo .
	echo Downloading $OPENSSL_GZ
    wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  $OPENSSL_DOWNLOAD_URL
    cp $OPENSSL_GZ /vagrant
fi

echo .
ls $DEST/*.tar.gz

echo .
echo Uncompressing $OPENSSL_GZ
tar -xf $OPENSSL_GZ

echo .
echo Installing dependencies for openssl
sudo apt-get update
sudo apt-get build-dep openssl -y

# Building $OPENSSL_VERSION
cd $OPENSSL_VERSION
./config
make depend
make
sudo make install

sudo rm -f /usr/bin/openssl
sudo rm -rf /usr/include/openssl/
sudo cp /usr/local/ssl/bin/openssl /usr/bin/
sudo cp -r /usr/local/ssl/include/openssl /usr/include
echo .
echo Setting up OPENSSL_SRC for vagrant user
echo "" >> /home/vagrant/.profile
echo export OPENSSL_SRC=/home/vagrant/$OPENSSL_VERSION >> /home/vagrant/.profile

