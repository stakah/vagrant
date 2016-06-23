#!/bin/sh

# provision.sh

echo "${0}"

# Destination folder
DEST=/home/vagrant

# api manager
am=wso2am
amv="1.10.0"
amversion=$am-$amv
amzip=$amversion.zip
amd="WSO2 API Manager $amv"
ams="wso2amd"

# Carbon config
CARBON_HOME=/opt/$am
CARBON_CONF=$CARBON_HOME/repository/conf/carbon.xml
OFFSET="0"

# To enable authentication by e-mail
#ENABLE_EMAIL_USERNAME=true
#USER_MGT_CONF=$CARBON_HOME/repository/conf/user-mgt.xml

#USER_NAME_ATTRIBUTE="mail"
#USER_NAME_SEARCH_FILTER='(&amp;(objectClass=identityPerson)(mail=?))'
#USER_NAME_LIST_FILTER='(&amp;(objectClass=identityPerson)(mail=*))'
#USER_NAME_JAVA_REGEX='^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$'
#ADMIN_EMAIL='admin@wso2.com'
#DATASOURCE = 'jdbc/WSO2UMDB'

MYSQL_DRV="mysql-connector-java-5.1.38"
MYSQL_DRV_ZIP="${MYSQL_DRV}.tar.gz"

echo "Sourcing $DEST/.profile"
. $DEST/.profile

echo JAVA_HOME=$JAVA_HOME

command -v unzip >/dev/null 2>&1 || {
    echo "Installing unzip..."
      sudo apt-get update
      sudo apt-get install unzip -y
}

echo "Copying $amzip compacted file ..."
cp -f "/vagrant/$amzip" $DEST

ls $DEST/*.zip

echo "Unzipping $amzip"
cd $DEST
unzip -o -q "$amzip"

echo "Removing $amzip"
rm -f "$amzip"

echo "Moving \"$amversion\" folder to /opt"
rm -rf "/opt/$amversion"
mv -f "$amversion" /opt
ls -lahd "/opt/$amversion"

echo "Chown to vagrant"
sudo chown -R vagrant:vagrant "/opt/$amversion"
ls -lahd "/opt/$amversion"

echo "Sym-linking to $amversion"
ln -s "/opt/$amversion" $CARBON_HOME
ls -lah $CARBON_HOME

#echo "Backing-up carbon.xml"
#cp $CARBON_CONF $CARBON_CONF.bkp

#echo "Changing $amd Port offset to $OFFSET"
#sed -i "s|\(<Offset>\)[^<>]*\(</Offset>\)|\1${OFFSET}\2|" $CARBON_CONF

#echo "Enabling e-mail authentication"
#sed -i "s|\(<!--EnableEmailUserName>\)[^<>]*\(</EnableEmailUserName-->\)|<EnableEmailUserName>${ENABLE_EMAIL_USERNAME}</EnableEmailUserName>|" $CARBON_CONF
#sed -i "s|\(<EnableEmailUserName>\)[^<>]*\(</EnableEmailUserName>\)|\1${ENABLE_EMAIL_USERNAME}\2|" $CARBON_CONF

#echo "Backing up user-mgt.xml"
#cp $USER_MGT_CONF $USER_MGT_CONF.bkp

#echo "Configuring $USER_MGT_CONF"
#sed -i "s|\(<Property name=\"UserNameAttribute\">\)[^<>]*\(/Property>\)|\1${USER_NAME_ATTRIBUTE}\2|"        $USER_MGT_CONF
#sed -i "s|\(<Property name=\"UserNameSearchFilter\">\)[^<>]*\(/Property>\)|\1${USER_NAME_SEARCH_FILTER}\2|" $USER_MGT_CONF
#sed -i "s|\(<Property name=\"UserNameListFilter\">\)[^<>]*\(/Property>\)|\1${USER_NAME_LIST_FILTER}\2|"     $USER_MGT_CONF
#sed -i "s|\(<Property name=\"UsernameJavaRegEx\">\)[^<>]*\(/Property>\)|\1${USER_NAME_JAVA_REGEX}\2|"       $USER_MGT_CONF
#sed -i "s|\(<Property name=\"UsernameJavascriptRegEx\">\)[^<>]*\(/Property>\)|\1${USER_NAME_JAVA_REGEX}\2|"       $USER_MGT_CONF

#echo "Setting MySQL Database"
#sed -i "s|\(<Property name=\"dataSource\">\)[^<>]*\(/Property>\)|\1${DATASOURCE}\2|"                        $USER_MGT_CONF

#echo "Changing admin login with admin's email"
#sed -i "s|\(<UserName>\)[^<>]*\(</UserName>\)|\1${ADMIN_EMAIL}\2|" $USER_MGT_CONF

#echo "Copying mysql driver"
#cp "/vagrant/$MYSQL_DRV_ZIP" $DEST

#echo "Gunzipping $MYSQL_DRV_ZIP"
#tar -xf "$MYSQL_DRV_ZIP"

#echo "Copying $MYSQL_DRV"
#cp "$MYSQL_DRV/${MYSQL_DRV}-bin.jar" "$CARBON_HOME/repository/components/dropins/"

#echo "Copying master-datasources.xml"
#cp -f "/vagrant/master-datasources.xml" "$CARBON_HOME/repository/conf/datasources/"

echo "Copying Puppet configuration files"
cp -rf /vagrant/conf $DEST/
echo "cp -rf /vagrant/conf $DEST/"

echo "Setting up as a service"
echo "Creating file $ams"

cat <<- EOF > $DEST/$ams
	#!/bin/sh

	# $ams

	export JAVA_HOME="$JAVA_HOME"

	startcmd='$CARBON_HOME/bin/wso2server.sh start 2> >(logger -s 2>> $DEST/$am.log) &'
	restartcmd='$CARBON_HOME/bin/wso2server.sh restart 2> >(logger -s 2>> $DEST/$am.log) &'
	stopcmd='$CARBON_HOME/bin/wso2server.sh stop 2> >(logger -s 2>> $DEST/$am.log) &'

	case "\$1" in
	start)
	  echo "$amd ..."
	   su -c "\${startcmd}" vagrant
	;;
	restart)
	   echo "Re-starting $amd ..."
	   su -c "\${restartcmd}" vagrant
	;;
	stop)
	   echo "Stopping $amd ..."
	   su -c "\${stopcmd}" vagrant
	;;
	*)
	   echo "Usage: \$0 {start|stop|restart}"
	exit 1
	esac

EOF

echo Creating status.sh
cat <<- EOF > $DEST/status.sh
	#!/bin/sh

	# status.sh
	CARBON_HOME="$CARBON_HOME"
	CARBON_PID_FILE="\$CARBON_HOME/wso2carbon.pid"

	echo "Waiting for $amd service to start ..."

	  while [ ! -e "\$CARBON_PID_FILE" ]
	  do
	  	sleep 5;
	  done
	  
	  process_status=1
	  until [ "\$process_status" -eq "0" ]
	  do
	        sudo netstat -tapenl | grep ":8244 " 2>&1 > /dev/null
	        process_status=\$?
	        sleep 5;
	  done

	CARBON_PID=\$(cat \$CARBON_PID_FILE)
	
	echo "$amd started with PID \$CARBON_PID"
	
EOF

echo chmod +x on status.sh
chmod a+x $DEST/status.sh

echo chmod +x on wso2server
chmod a+x $DEST/$ams

echo sym-linking in /etc/init.d/$ams
sudo ln -snf $DEST/$ams /etc/init.d/$ams

echo updating service
sudo update-rc.d $ams defaults

echo starting $amd service
sudo service $ams start

#sh $DEST/status.sh
	
