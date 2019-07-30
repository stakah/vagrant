#!/bin/bash

BASEDIR=/vagrant/amzl2
source $BASEDIR/envvar.sh

FILE=/etc/my.cnf
if [ ! -f "${FILE}.bk" ]; then
	echo "Copying $FILE to $FILE.bk"
	sudo cp $FILE $FILE.bk
fi

echo "Stoping mysqld ..."
sudo systemctl stop mysqld

echo "Disabling grant tables ..."
sed "5iskip-grant-tables" $FILE.bk | sudo tee -a $FILE > /dev/null

echo "Restarting mysql server ..."
sudo systemctl restart mysqld

echo "Editing root's password ..."

BASE_DIR=/vagrant/provisioning
SQL_FILE=$BASE_DIR/set-mysql-root.sql

touch $SQL_FILE
(
cat << EOF
flush privileges;

-- Droping the user if already exists
GRANT USAGE ON *.* TO 'root'@'localhost';

DROP USER 'root'@'localhost';

FLUSH PRIVILEGES;

-- Recreating the root user
CREATE USER 'root'@'localhost' IDENTIFIED BY '$AMZL2_MYSQL_ROOT_PASSWD';

-- Granting privileges
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
EOF
) > $SQL_FILE

mysql -u root --force < $SQL_FILE

rm -f $SQL_FILE

sudo cp -f $FILE.bk $FILE

shopt -s extglob

REP="[client]
user = root
password = $AMZL2_MYSQL_ROOT_PASSWD
"

REP="${REP//+(
)/\\n}"

sed "4i$REP" $FILE.bk | sudo tee -a $FILE.2 > /dev/null
sudo cp -f $FILE.2 $FILE
sudo rm -f $FILE.2

echo "Restarting mysql server ..."
sudo systemctl restart mysqld
