#! /bin/bash

APPNAME="APPNAME"
APPPATH="/var/www/magento"

cd "$APPPATH"

echo "Symlink theme files"
if [ ! -d $APPPATH/skin/frontend/$APPNAME ]; then sudo ln -s /vagrant/src/skin $APPPATH/skin/frontend/$APPNAME; fi
if [ ! -d $APPPATH/app/design/frontend/$APPNAME ]; then sudo ln -s /vagrant/src/design $APPPATH/app/design/frontend/$APPNAME; fi
if [ ! -d $APPPATH/yaml ]; then sudo ln -s /vagrant/src/yaml $APPPATH/yaml; fi
if [ ! -e $APPPATH/staticpage.php ]; then sudo ln -s /vagrant/src/staticpage.php $APPPATH/staticpage.php; fi

# enable symlinks
n98-magerun.phar dev:symlinks 2

# set theme package
n98-magerun.phar config:set --scope="stores" --scope-id="2" design/package/name "$APPNAME"

# set theme template
n98-magerun.phar config:set --scope="stores" --scope-id="2" design/theme/template "default"

# set theme skin
n98-magerun.phar config:set --scope="stores" --scope-id="2" design/theme/skin "default"

# set theme layout
n98-magerun.phar config:set --scope="stores" --scope-id="2" design/theme/layout "default"

# set theme default
n98-magerun.phar config:set --scope="stores" --scope-id="2" design/theme/default "default"
