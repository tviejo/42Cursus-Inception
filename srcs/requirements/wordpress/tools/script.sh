#!/bin/bash

# Check if wp-config.php already exists
if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress already set up."
else
    # Download WordPress core files if not already present
    wp core download --path=/var/www/html --force --allow-root

    # Copy wp-config-sample.php to wp-config.php
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    # Configure wp-config.php with environment variables
    sed -i "s/database_name_here/${SQL_DATABASE}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${SQL_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${SQL_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${SQL_HOST:-mariadb}/" /var/www/html/wp-config.php

    # Generate and replace Authentication Unique Keys and Salts in wp-config.php
    AUTH_KEYS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
    sed -i "/AUTH_KEY/d" /var/www/html/wp-config.php
    sed -i "/put your unique phrase here/d" /var/www/html/wp-config.php
    echo "$AUTH_KEYS" >> /var/www/html/wp-config.php

    # Append configurations to wp-config.php
    echo "define('FORCE_SSL_ADMIN', true);" >> /var/www/html/wp-config.php
    echo "if (strpos(\$_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) {" >> /var/www/html/wp-config.php
    echo "    \$_SERVER['HTTPS'] = 'on';" >> /var/www/html/wp-config.php
    echo "}" >> /var/www/html/wp-config.php
fi

# Install WordPress
wp core install --url="${WP_URL}" --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" --allow-root

# Create admin user
wp user create "${WP_ADMIN_USER}" "${WP_ADMIN_EMAIL}" --role=administrator --user_pass="${WP_ADMIN_PASSWORD}" --allow-root

# Create an additional user
wp user create "${WP_USER}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PASSWORD}" --allow-root

wp cache flush --allow-root
wp rewrite flush --allow-root

# Start PHP-FPM in the foreground
exec php-fpm7.4 -F
