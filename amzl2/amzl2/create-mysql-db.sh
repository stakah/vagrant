#!/bin/bash

BASEDIR=/vagrant/amzl2
source $BASEDIR/envvar.sh

FILE=$BASEDIR/create-mysql-db.sql

echo "pwd $(pwd)"

echo "Injecting db, user and password into $FILE"
touch $FILE
(
cat << EOF
CREATE DATABASE IF NOT EXISTS $AMZL2_MYSQL_DB
CHARACTER SET 'utf8';
EOF
) > $FILE

# echo "" > $FILE
# echo "CREATE DATABASE IF NOT EXISTS $AMZL2_MYSQL_DB" >> $FILE
# echo "CHARACTER SET 'utf8';" >> $FILE

echo "Creating database instance"
mysql -u root < $FILE

# rm -f $FILE