
################## APACHE INSTALLATION ######################

echo -e "\033[1m# Installing Apache  \033[0m"
sudo apt-get update
sudo apt-get install apache2

# ADD TO apache2.conf: ServerName server_domain_or_IP
# RUN sudo apache2ctl configtest TO TEST IT

sudo systemctl restart apache2
sudo ufw allow in "Apache Full"

################## MYSQL INSTALLATION ######################
echo -e "\033[1m# Installing MySQL  \033[0m"
sudo apt-get install mysql-server
sudo mysql_secure_installation

################## PHP INSTALLATION ######################
echo -e "\033[1m# Setting up PHP \033[0m"
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql
sudo apt-get install php-cli
# CHANGE /etc/apache2/mods-enabled/dir.conf TO LOOK FOR .php FIRST
sudo systemctl restart apache2
sudo systemctl status apache2

################## PHPMYADMIN INSTALLATION ######################
echo -e "\033[1m# Installing PHP my ADMIN \033[0m"
sudo apt-get install phpmyadmin
sudo php5enmod mcrypt
sudo su
echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache2.conf
exit
sudo service apache2 restart
