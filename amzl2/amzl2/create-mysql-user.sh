#!/bin/bash
BASEDIR=/vagrant/amzl2
source $BASEDIR/envvar.sh

FILE=$BASEDIR/create-mysql-user.sql
echo "Injecting db, user and password into $FILE"

(
cat << EOF
-- Droping the user if already exists
-- DROP USER '$AMZL2_MYSQL_USER';
FLUSH PRIVILEGES;

-- Recreating the user
CREATE USER '$AMZL2_MYSQL_USER' IDENTIFIED BY '$AMZL2_MYSQL_PASSWD';

-- Granting privileges
GRANT ALL PRIVILEGES ON $AMZL2_MYSQL_DB.* TO $AMZL2_MYSQL_USER;
GRANT USAGE ON *.* TO '$AMZL2_MYSQL_USER';
FLUSH PRIVILEGES;
EOF
) > $FILE

echo "Creating user '$AMZL2_MYSQL_USER' ..."
mysql -u root --force < $FILE

# rm -f $FILE