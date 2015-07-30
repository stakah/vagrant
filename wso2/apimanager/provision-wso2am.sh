#!/bin/sh

# provision.sh

echo ${0}

# Destination folder
DEST=/home/vagrant

# api manager
am=wso2am
amv=1.9.0
amversion=$am-$amv
amzip=$amversion.zip
amd="WSO2 API Manager $amv"
ams="wso2amd"

# Carbon config
CARBON_HOME=/opt/$am
CARBON_CONF=$CARBON_HOME/repository/conf/carbon.xml
OFFSET="1"

echo sourcing $DEST/.profile
. $DEST/.profile

echo JAVA_HOME=$JAVA_HOME

echo installing unzip 
sudo apt-get install unzip

echo Copying $amd compacted file ...
cp -f /vagrant/$amzip $DEST

ls $DEST/*.zip

echo Unzipping $amzip
cd $DEST
unzip -o -q $amzip

echo Removing $amzip
rm -f $amzip

echo moving $amversion folder to /opt
rm -rf /opt/$amversion
mv -f $amversion /opt
ls -lahd /opt/$amversion

echo chown to vagrant
sudo chown -R vagrant:vagrant /opt/$amversion
ls -lahd /opt/$amversion

echo sym-linking to $amversion
ln -s /opt/$amversion $CARBON_HOME
ls -lah $CARBON_HOME

echo Backing-up carbon.xml
cp $CARBON_CONF $CARBON_CONF.bkp

echo Changing $amd Port offset to $OFFSET
sed -i "s|\(<Offset>\)[^<>]*\(</Offset>\)|\1${OFFSET}\2|" $CARBON_CONF

echo setting up as a service
echo creating file $ams

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

sh $DEST/status.sh
	