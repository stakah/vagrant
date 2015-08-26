#!/bin/bash

#Php and Drivers 
apt-get install -y php5 libapache2-mod-php5 php5-intl php-apc php5-gd php5-curl php5-mysql phpunit

#PhpUnit
pear upgrade pear
pear channel-discover pear.phpunit.de
pear channel-discover components.ez.no
pear channel-discover pear.symfony.com
pear install --alldeps phpunit/PHPUnit

#Php Configuration
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 10M/" /etc/php5/apache2/php.ini
sed -i "s/short_open_tag = On/short_open_tag = Off/" /etc/php5/apache2/php.ini
sed -i "s/;date.timezone =/date.timezone = Europe\/Berlin/" /etc/php5/apache2/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /etc/php5/apache2/php.ini
sed -i "s/_errors = Off/_errors = On/" /etc/php5/apache2/php.ini
