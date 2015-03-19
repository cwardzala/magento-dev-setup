# magento-dev-setup
Magento local development setup

## Keywords
Through out this document and the refrenced files, variables will be used to designate places where custom vaules will need to be entered to successfully setup the development environment. Any time you see a variable replace it with the correct value for your setup.

- `#DOMAIN` This will be your local development server domain (e.g. example.dev)
- `#PROD DOMAIN` This is your current production domain, if you have one.
- `#PROD COOKIE DOMAIN` This is your current production cookie domain, if you have one.
- `#MAGENTO DOWNLOAD URL` URL to download Mageno `tar.gz`.

## Requirements

- Virtualbox
- Vagrant >= v1.5
- Hosts file entry for `127.0.0.1 #DOMAIN`

## Magento Folder mapping
By default `files/setup_theme.sh` and `files/setup_modules.sh` will setup symlinks for development. It is still helpful to know how the local development folders map to Magento's folder structure.

```
src/design  -> /var/www/magento/app/design/frontend/#DOMAIN
src/lib/*   -> /var/www/magento/lib (only files not full directory)
src/modules -> /var/www/magento/app/code/local
src/skin    -> /var/www/magento/skin/frontend/#DOMAIN
src/xml/*   -> /var/www/magento/app/etc/modules (only files not full directory)
```

## Local SSL/HTTPS
*This needs to be done before provisioning your machine*

To run locally with SSL you need a self-signed certificate. [Directions via Digial Ocean](https://www.digitalocean.com/community/tutorials/how-to-create-a-ssl-certificate-on-apache-for-ubuntu-14-04#step-two-—-create-a-self-signed-ssl-certificate). 
Copy these files to a `certs` folder under your project's `dont_commit` folder.

## Running locally
```bash
# Create a database dump from your production MySQL if you need it.
# Name the dump file MAGENTO_DB_BACKUP.sql
# Copy this to ./files/MAGENTO_DB_BACKUP.sql

# Start vagrant
$ vagrant up

# after provisioning server should now be running at http://#DOMAIN:8181 and https://#DOMAIN:8383

# SSH into your vagrant and cd into /vagrant/files
$ vagrant ssh
$ cd /vagrant/files

# Run the following commands to finish setting up your local environment.
$ ./setup_db.sh # Create and import DB, clean urls.
$ ./setup_theme.sh # Symlink theme directories and setup theme in Magento admin.
$ ./setup_modules.sh #Symlink module files and folders. Every time you add a new module you will need to run this.

# if commands wont run open each file and run the commands line-by-line.
```
