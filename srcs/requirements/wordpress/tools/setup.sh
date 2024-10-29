#!/bin/bash

# Wait for MariaDB to be ready
while ! mysqladmin ping -h${MYSQL_HOST} --silent; do
    sleep 1
done

# Configure WordPress
cd /var/www/wordpress

cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
sed -i "s/localhost/${MYSQL_HOST}/" wp-config.php

# Install WordPress using WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core install --url=${DOMAIN_NAME} --title="Inception" \
    --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} --skip-email --path=/var/www/wordpress

wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author --path=/var/www/wordpress

# Start PHP-FPM in the foreground
php-fpm7.3 -F
