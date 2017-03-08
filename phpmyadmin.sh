apt-get install phpmyadmin
phpenmod mcrypt

echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache2.conf

service apache2 restart
