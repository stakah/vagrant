#!/bin/sh

# provision.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# apache tomcat 9
#http://ftp.unicamp.br/pub/apache/tomcat/tomcat-9/v9.0.0.M4/bin/apache-tomcat-9.0.0.M4.tar.gz
#http://mirror.nbtelecom.com.br/apache/tomcat/tomcat-9/v9.0.0.M4/bin/apache-tomcat-9.0.0.M4.tar.gz

TOMCAT="apache-tomcat"
TOMCAT_MAJOR_V="9"
TOMCAT_MINOR_V="0.0"
TOMCAT_REV="M4"
TOMCAT_V=${TOMCAT_MAJOR_V}.${TOMCAT_MINOR_V}.${TOMCAT_REV}
TOMCAT_VERSION=$TOMCAT-$TOMCAT_V
TOMCAT_GZ=$TOMCAT_VERSION.tar.gz
TOMCAT_DESCRIPTION="Apache Tomcat9 $isv"
TOMCAT_DOWNLOAD_URL="http://ftp.unicamp.br/pub/apache/tomcat/tomcat-${TOMCAT_MAJOR_V}/v${TOMCAT_V}/bin/${TOMCAT_GZ}"

# Tomcat config
TOMCAT_CONF=/opt/$TOMCAT/conf/server.xml
#OFFSET="0"

#echo .
#echo installing unzip 
#sudo apt-get update
#sudo apt-get install unzip

if [ -f /vagrant/$TOMCAT_GZ ]; then 
    echo .
    echo Copying $TOMCAT_VERSION
    cp -f /vagrant/$TOMCAT_GZ $DEST
else
	echo .
	echo Downloading $TOMCAT_GZ
    wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  $TOMCAT_DOWNLOAD_URL
    cp $TOMCAT_GZ /vagrant
fi

echo .
ls $DEST/*.tar.gz

echo .
echo Uncompressing $TOMCAT_GZ
tar -xf $TOMCAT_GZ

#echo .
#echo Unzipping $TOMCAT_GZ
#cd $DEST
#unzip -o -q $TOMCAT_GZ

#echo .
#echo Removing $TOMCAT_GZ
#rm -f $TOMCAT_GZ

echo .
echo moving $TOMCAT_VERSION folder to /opt
rm -rf /opt/$TOMCAT_VERSION
mv -f $TOMCAT_VERSION /opt
ls -lahd /opt/$TOMCAT_VERSION

echo .
echo chown to vagrant
chown -R vagrant:vagrant /opt/$TOMCAT_VERSION
ls -lahd /opt/$TOMCAT_VERSION

echo .
echo sym-linking to $TOMCAT_VERSION
ln -s /opt/$TOMCAT_VERSION /opt/$TOMCAT
ls -lah /opt/$TOMCAT

echo .
echo Setting up CATALINA_HOME for vagrant user
echo "" >> /home/vagrant/.profile
echo export CATALINA_HOME=/opt/$TOMCAT >> /home/vagrant/.profile

echo .
echo Backing-up server.xml
cp $TOMCAT_CONF $TOMCAT_CONF.bkp

echo .
echo Copying http/2 enabled server.xml file
cp /vagrant/server.xml $TOMCAT_CONF

echo .
echo Copying /vagrant/provision-ssl.sh
cp /vagrant/provision-ssl.sh .
chmod +x provision-ssl.sh

echo .
echo Copying /vagrant/openssl.config
cp /vagrant/openssl.config .

ls -l provision-ssl.sh
ls -l openssl.config

echo .
echo Generating Certificates 
sh provision-ssl.sh

echo .
echo Copying certificates to $TOMCAT/conf
cp ./ca.key /opt/$TOMCAT/conf/
cp ./ca.crt /opt/$TOMCAT/conf/

echo .
echo Copying /vagrant/provision-apr.sh
cp /vagrant/provision-apr.sh .
chmod +x provision-apr.sh

echo .
echo Compiling APR
sh provision-apr.sh

echo .
echo Copying /vagrant/provision-openssl.sh
cp /vagrant/provision-openssl.sh .
chmod +x provision-openssl.sh

echo .
echo Compiling openssl
sh provision-openssl.sh

echo .
echo Copying /vagrant/provision-tcn.sh
cp /vagrant/provision-tcn.sh .
chmod +x provision-tcn.sh

echo .
echo Compiling Tomcat Native Library
sh provision-tcn.sh

#echo .
#echo Changing $isd Port offset to $OFFSET
#sed -i "s|\(<Offset>\)[^<>]*\(</Offset>\)|\1${OFFSET}\2|" $CARBON_CONF

#echo .
#echo Creating startup script
#echo Use: sh ./startup.sh
#cp -f /vagrant/startup.sh $DEST/startup.sh

#echo .
#echo chmod +x on startup.sh
#chmod a+x $DEST/startup.sh
