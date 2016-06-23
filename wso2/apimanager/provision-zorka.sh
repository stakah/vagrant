#!/bin/sh

# provision.sh

echo "${0}"

# Destination folder
DEST=/home/vagrant

# api manager
am=wso2am
amv="1.10.0"
amversion=$am-$amv

# Carbon config
CARBON_HOME=/opt/$am
CARBON_CONF=$CARBON_HOME/repository/conf/carbon.xml

#ZORKA config
zorka=zorka
zorkav="1.0.15"
zorkaversion=$zorka-$zorkav
zorkazip=${zorkaversion}.zip
zorka_home="$CARBON_HOME/zorka"

JAVA_OPTS="\$JAVA_OPTS -javaagent:$zorka_home/zorka.jar=$zorka_home -Dcom.sun.management.jmxremote"

echo "Sourcing $DEST/.profile"
. $DEST/.profile

echo JAVA_HOME=$JAVA_HOME

command -v unzip >/dev/null 2>&1 || {
    echo "Installing unzip..."
      sudo apt-get update
      sudo apt-get install unzip -y
}

echo "Copying $zorkazip compacted file ..."
cp -f "/vagrant/$zorkazip" $DEST

ls $DEST/$zorkazip

echo "Unzipping $zorkazip"
cd $DEST
unzip -o -q "$zorkazip"

echo "Removing $zorkazip"
rm -f "$zorkazip"

echo "Moving \"$zorkaversion\" folder to $CARBON_HOME/"
rm -rf "$CARBON_HOME/$zorkaversion"
mv -f "$zorkaversion" $CARBON_HOME
ls -lahd "$CARBON_HOME/$zorkaversion"

echo "Chown to vagrant"
sudo chown -R vagrant:vagrant "$CARBON_HOME/$zorkaversion"
ls -lahd "$CARBON_HOME/$zorkaversion"

echo "Sym-linking to $zorkaversion"
ln -s "$CARBON_HOME/$zorkaversion" $CARBON_HOME/$zorka
ls -lah $CARBON_HOME/$zorka

echo "Copying zorka.properties"
cp /vagrant/zorka.properties $CARBON_HOME/$zorkaversion/
ls -lah $CARBON_HOME/$zorkaversion/zorka.properties

echo "Backing-up $CARBON_HOME/bin/wso2server.sh"
cp $CARBON_HOME/bin/wso2server.sh $CARBON_HOME/bin/wso2server.sh.bkp
ls -lah $CARBON_HOME/bin/wso2server.sh.bkp

echo "Configuring wso2server.sh"
cp /vagrant/wso2server.sh $CARBON_HOME/bin/
sed -i "s|JAVA_OPTS=\"\(<JAVA_OPTS>\"\)|JAVA_OPTS=\"$JAVA_OPTS\"|" $CARBON_HOME/bin/wso2server.sh
grep JAVA_OPTS= $CARBON_HOME/bin/wso2server.sh

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

	
