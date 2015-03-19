#!/bin/bash

APPNAME="library.playaway.dev"
APPPATH="/var/www/$APPNAME"
RED='\e[0;31m'
GREEN='\e[0;32m'
NC='\e[0m'
cd "$APPPATH"
echo "Remove existing symlinks in the adminhtml theme"
echo -e "${RED}The following links will be removed${NC}"
find ./app/design/adminhtml -type l
find ./app/design/adminhtml -type l -exec rm -f {} \;

echo ""
echo "Symlink adminhtml theme directories"
echo -e "${GREEN}The following directories will be linked${NC}"
echo "/vagrant/src/admin_design/layout -> $APPPATH/app/design/adminhtml/default/default/layout/findaway"
echo "/vagrant/src/admin_design/template -> $APPPATH/app/design/adminhtml/default/default/template/findaway"

sudo ln -s /vagrant/src/admin_design/layout $APPPATH/app/design/adminhtml/default/default/layout/findaway
sudo ln -s /vagrant/src/admin_design/template $APPPATH/app/design/adminhtml/default/default/template/findaway

echo ""
