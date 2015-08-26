export VAGRANT_SYNCED_DIR=$1
export VAGRANT_COMPONENTS_DIR="${VAGRANTS_SYNCED_DIR}/vagrant/components"

# Make sure the shared folder is readable
chmod -R 755 $1

# apt: mirror setup to use de mirror
sed -i "s/us\.archive\.ubuntu\.com/de\.archive\.ubuntu\.com/" /etc/apt/sources.list
apt-get update

# joe, pwgen, git and apt-tools
apt-get install -y joe pwgen git

# disable backup files in joe
sed -i "s/\n -nobackups/\n-nobackups/" /etc/joe/joerc

$VAGRANT_COMPONENTS_DIR/apache.sh
$VAGRANT_COMPONENTS_DIR/php.sh
$VAGRANT_COMPONENTS_DIR/composer.sh
$VAGRANT_COMPONENTS_DIR/mariadb.sh

#Reload apache configuration
/etc/init.d/apache2 restart

echo "------------------------------------------"
echo "Okay, your vagrant-lamp Box is all set up."
echo "Point your browser to http://10.10.47.11/ and start rockin'!"

if [ -f $VAGRANT_SYNCED_DIR/composer.json ]
then
	echo "P.S.: It seems like you are using composer. SSH into your box "
	echo "and install your dependencies with these commands:"
	echo "	vagrant ssh"
	echo "	composer.phar install"
fi