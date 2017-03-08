# Author: Pedro Dousseau
# website: dousseau.me
# Email: pedro@dousseau.com
# Version: 1.0
# Data: 02/02/2017
# Description: Set up a wordpress website. Apache configuration not included.
#              Must run as sudo.

# ATENTION HERE!
target_wp_path=path_to_put_wordpress_goes_here

echo -e "\n\n\033[1m---------------- CONFIGURING WORDPRESS ------------------\n\033[0m"

echo -e "\033[1mConfiguring database\033[0m"
mysql < set_wp_db.sql

echo -e "\033[1mExtracting wordpress\033[0m"
tar xzf wordpress.tar.gz -C $target_wp_path/
cp wp-config.php $target_wp_path/wordpress/wp-config.php
curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> $target_wp_path/wordpress/wp-config.php
cat wp-config2.php >> $target_wp_path/wordpress/wp-config.php
cd $target_wp_path/wordpress/

echo -e "\033[1mCreating files and adjusting permissions\033[0m"
touch .htaccess
chmod 660 .htaccess
mkdir wp-content/upgrade

chown -R $USER:www-data .

find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;

find wp-content/ -type d -exec chmod 775 {} \;
find wp-content/ -type f -exec chmod 664 {} \;

find wp-content/plugins/ -type d -exec chmod 755 {} \;
find wp-content/plugins/ -type f -exec chmod 644 {} \;


echo -e "\033[1m-------------------- WORDPRESS READY! ---------------------\033[0m"
