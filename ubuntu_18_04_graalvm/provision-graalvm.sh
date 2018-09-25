#!/bin/sh

# provision-graalvm.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# graalvm
graalvm="graalvm"
graalvmmainv="1.0.0"
graalvmupdatev="rc6"
graalvmv="${graalvmmainv}-${graalvmupdatev}"
graalvmdist="vm-${graalvmv}"
graalvmos="linux"
graalvmarc="amd64"
graalvmversion="${graalvm}-ce-${graalvmv}-${graalvmos}-${graalvmarc}"
graalzip="${graalvmversion}.tar.gz"
graalvmfolder="graalvm-ce-${graalvmmainv}-${graalvmupdatev}"


# https://github.com/oracle/graal/releases/download/vm-1.0.0-rc6/graalvm-ce-1.0.0-rc6-linux-amd64.tar.gz

if [ -f /vagrant/$graalzip ]; then 
    echo Copying $graalvmversion
    cp -f /vagrant/$graalzip $DEST
else
	echo Downloading $graalzip
    wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  https://github.com/oracle/graal/releases/download/${graalvmdist}/$graalzip
    cp $graalzip /vagrant
fi

echo Uncompressing $graalzip
tar -xf $graalzip

echo Moving $graalvmfolder folder to /usr/java
mkdir -p /usr/java
rm -rf /usr/java/$graalvmfolder
mv -f $graalvmfolder /usr/java

echo Removing $graalzip
rm -f $graalzip

echo Setting up GRAALVM_HOME for vagrant user
echo "" >> /home/vagrant/.profile
echo export GRAALVM_HOME=/usr/java/$graalvmfolder >> /home/vagrant/.profile
echo PATH=$PATH:\$GRAALVM_HOME/bin >> /home/vagrant/.profile

echo exporting GRAALVM_HOME
export GRAALVM_HOME=/usr/java/$graalvmfolder
echo "GRAALVM_HOME=$GRAALVM_HOME"
