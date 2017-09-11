DROP DATABASE IF EXISTS wordpress_db_name;
CREATE DATABASE wordpress_db_name DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON wordpress_db_name.* TO 'wordpress_db_user'@'localhost' IDENTIFIED BY 'wordpress_db_user_password';
FLUSH PRIVILEGES;
