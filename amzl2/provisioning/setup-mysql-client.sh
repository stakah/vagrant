#!/bin/bash

echo "Intalling MySQL Client"

sudo yum update -y

progressfilt ()
{
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c
    do
        if $flag
        then
            printf '%s' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]
            then
                count=0
            else
                ((count++))
                if ((count > 1))
                then
                    flag=true
                fi
            fi
        fi
    done
}

FILE=mysql-8.0.16-2.el7.x86_64.rpm-bundle.tar

# ls -l /vagrant
if [ ! -f "/vagrant/$FILE" ]; then
    echo "Downloading $FILE ..."
    sudo wget --progress=bar:force https://dev.mysql.com/get/$FILE | progressfilt
    sudo cp $FILE /vagrant/$FILE
else
    sudo cp /vagrant/$FILE .
fi

tar xf $FILE

# ls -la 

sudo yum localinstall -y mysql-community-common-8.0.16-2.el7.x86_64.rpm \
                         mysql-community-devel-8.0.16-2.el7.x86_64.rpm \
                         mysql-community-embedded-compat-8.0.16-2.el7.x86_64.rpm \
                         mysql-community-libs-8.0.16-2.el7.x86_64.rpm \
                         mysql-community-libs-compat-8.0.16-2.el7.x86_64.rpm \
                         mysql-community-client-8.0.16-2.el7.x86_64.rpm \
                         mysql-community-server-8.0.16-2.el7.x86_64.rpm \
                         mysql-community-test-8.0.16-2.el7.x86_64.rpm

sudo yum install -y mysql-community-libs mysql-community-client mysql-community-devel

# systemctl start mysqld.service