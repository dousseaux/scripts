# Author: Pedro Dousseau
# website: dousseau.me
# Email: pedro@dousseau.com
# Version: 1.0
# Data: 02/02/2017
# Description: Script to set up self-signed ssl with apache.

# IMPORTANT. SPECIFY THE NAME
websitename=your_website_name_goes_here

echo -e "\033[1m---------------- CONFIGURING SSL AND APACHE WEBSITES ------------------\n\033[0m"

echo -e "\033[1mCreating a self-signed key and certificate pair with OpenSSL.\033[0m";
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt

echo -e "\033[1mCreating a strong Diffie-Hellman group.\033[0m"
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

echo -e "\033[1mSetting up Apache SSL securely.\033[0m"
cp -f ssl-params.conf /etc/apache2/conf-available/ssl-params.conf
a2enmod ssl
a2enmod headers
apache2ctl configtest
service apache2 restart

echo -e "\033[1mConfigurating default websites.\033[0m"
cp -f website-ssl.conf /etc/apache2/sites-available/$websitename-ssl.conf
cp -f website-redirect-ssl.conf /etc/apache2/sites-available/$websitename-redirect.conf
a2dissite 000-default.conf
a2dissite  $websitename-ssl.conf
a2dissite  $websitename-redirect.conf
service apache2 reload
a2ensite  $websitename-ssl.conf
a2ensite  $websitename-redirect.conf
service apache2 reload
