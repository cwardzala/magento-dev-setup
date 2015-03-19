#! /bin/bash

APPPATH="/var/www/magento"

cd "$APPPATH"

echo "Symlink module files"

sudo rm -rf $APPPATH/app/code/local
sudo ln -s /vagrant/src/modules $APPPATH/app/code/local

sudo cp -rs /vagrant/src/xml/* $APPPATH/app/etc/modules
sudo cp -rs /vagrant/src/lib/* $APPPATH/lib

n98-magerun.phar cache:flush
