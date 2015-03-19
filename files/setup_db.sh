#! /bin/bash

APPPATH="/var/www/magento"

cd "$APPPATH"

n98-magerun.phar db:drop

echo "Create DB"
n98-magerun.phar db:create

#import db
DBFILE="/vagrant/files/MAGENTO_DB_BACKUP.sql"
if [ ! -e $DBFILE ]; then
    echo "Import DB"
    n98-magerun.phar db:import $DBFILE;

    # fix URLs
    echo "Truncate Tables"
    n98-magerun.phar db:import "/vagrant/files/truncate_tables_dev.sql"

    # fix URLs
    echo "Fix URLs"
    n98-magerun.phar db:import "/vagrant/files/fix_db.sql"

    echo "Set Search to Full Text"
    n98-magerun.phar config:set catalog/search/engine catalogsearch/fulltext_engine
fi

echo "Empty Cache"
n98-magerun.phar cache:clean
n98-magerun.phar cache:flush

echo "Disable Cache"
n98-magerun.phar cache:disable
