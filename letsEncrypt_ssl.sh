# Author: Pedro Dousseau
# website: dousseau.me
# Email: pedro@dousseau.com
# Version: 1.1
# Data: 09/02/2017
# Description: Script to set up a website with real ssl certificate using apache
# and letsencrypt.

# EDIT HERE
virtual_host_name=example
website_domain_name=example.com
website_root=/var/www/example/
# FINISH EDITING

echo -e "\033[1m---------------- SETTING UP APACHE WEBSITE WITH SSL ------------------\n\033[0m"

echo -e "\033[Setting up default Apache website.\033[0m"
cat > /etc/apache2/sites-available/$virtual_host_name.conf << EOL
    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName https://$website_domain_name
        ServerAlias https://www.$website_domain_name

        DocumentRoot $website_root

        <Directory $website_root>
            Options Indexes FollowSymLinks
            AllowOverride all
            Require all granted
            Order allow,deny
            allow from all
        </Directory>

        ErrorLog  ${APACHE_LOG_DIR}/$virtual_host_name.error.log
        CustomLog ${APACHE_LOG_DIR}/$virtual_host_name.access.log combined
    </VirtualHost>
EOL
a2ensite  $virtual_host_name.conf
service apache2 reload

# For ubuntu 16.04 the package is only called letsencrypt
echo -e "\033[1mInstalling Let's Encrypt Client.\033[0m";
sudo apt-get update
sudo apt-get install python-letsencrypt-apache

echo -e "\033[1mCreate certificate for domains.\033[0m";
sudo letsencrypt --apache -d $website_domain_name -d www.$website_domain_name
# certificate autorenew
echo "30 2 * * 1 /usr/bin/letsencrypt renew >> /var/log/le-renew.log" >> $HOME/crontabs.txt
crontab $HOME/crontabs.txt
echo -e "\033[1mCertificate available at /etc/letsencrypt/live \033[0m"
