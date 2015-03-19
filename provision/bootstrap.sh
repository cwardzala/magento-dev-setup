#! /bin/bash

APPNAME="#DOMAIN"
APPPATH="/var/www/magento"

# update sources
echo "Update Sources"
sudo apt-get update

# install apache2
echo "Install Apache, php5, and mod-php5"
sudo apt-get -y install apache2 libapache2-mod-php5 php5 build-essential curl

echo "Install php mods"
sudo apt-get -y install php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xdebug

echo "Enable PHP Mcrypt"
php5enmod mcrypt

echo "Copy macros"
sudo cp /vagrant/files/macros.conf /etc/apache2/conf-available/macros.conf

echo "Copy xdebug.ini"
sudo cp /vagrant/files/xdebug.ini /etc/php5/mods-available/xdebug.ini

echo "enable apache modules"
sudo a2enmod rewrite deflate headers php5 macro ssl

echo "disable apache default site"
sudo a2dissite 000-default

echo "Enable macros config"
sudo a2enconf macros

echo "reload apache"
sudo service apache2 reload

# setup and install MariaDB
echo "setup mariadb sources"
sudo apt-get install software-properties-common -y
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://mirrors.syringanetworks.net/mariadb/repo/10.0/ubuntu trusty main'

echo "install mariadb"
sudo apt-get update

sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password root'

sudo apt-get -y -q install mariadb-server

# Download and extract Magento
echo "Download Magento"
curl --silent --output /tmp/magento.gz "#MAGENTO DOWNLOAD URL"

echo "Create app dir"
sudo mkdir -p $APPPATH

echo "Un-zip Magento"
sudo tar xzf /tmp/magento.gz -C $APPPATH

echo "move Magento files"
sudo mv $APPPATH/*/* "$APPPATH/"

echo "Remove old Magento folder"
sudo rm -rf $APPPATH/magento

echo "Chmod Magento var folder"
sudo chmod 777 $APPPATH/var

echo "Copy Magento local.xml"
sudo cp /vagrant/files/local.xml $APPPATH/app/etc/local.xml

# Add and enable site
echo "Copy site config"
sudo cp /vagrant/files/vhost.conf /etc/apache2/sites-available/$APPNAME.conf

echo "Copy .htaccess"
sudo ln -s /vagrant/.htaccess $APPPATH/.htaccess

echo "enable site"
sudo a2ensite $APPNAME

echo "Reload apache"
sudo service apache2 reload

# install magerun
echo "Install n98-magerun"
curl --silent -L --output /tmp/n98-magerun.phar https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar

echo "Change permissions on magerun"
chmod +x /tmp/n98-magerun.phar

echo "install magerun globally"
sudo cp /tmp/n98-magerun.phar /usr/local/bin/

echo "Set MAGE_IS_DEVELOPER_MODE"
export MAGE_IS_DEVELOPER_MODE=true
