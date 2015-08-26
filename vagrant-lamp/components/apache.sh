#!/bin/bash

apt-get install -y apache2

# determine a reasonable docroot
if [ -d ${VAGRANT_SYNCED_DIR}/web ]
	then
	DOCROOT="/web"
elif [ -d ${VAGRANT_SYNCED_DIR}/htdocs ]
	then
	DOCROOT="/htdocs"
elif [ -d ${VAGRANT_SYNCED_DIR}/public ]
	then
	DOCROOT="/public"
else
	# use the project root as a fallback
	DOCROOT=""
fi


# add a fqdn to ommit implicit localhost setting
echo "ServerName localhost" >> /etc/apache2/httpd.conf
# webroot
sed -i "s#DocumentRoot /var/www#DocumentRoot ${VAGRANT_SYNCED_DIR}${DOCROOT}#" /etc/apache2/sites-enabled/000-default
sed -i "s#<Directory /var/www/>#<Directory ${VAGRANT_SYNCED_DIR}${DOCROOT}/>#" /etc/apache2/sites-enabled/000-default
