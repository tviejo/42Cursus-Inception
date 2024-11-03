#!/bin/bash

if [ -f "/var/www/html/wp-config.php" ]; then
	echo "WordPress is already set up."
else
	if [ -z "${SQL_DATABASE:-}" ] || [ -z "${SQL_USER:-}" ] || \
	   [ -z "${WP_URL:-}" ] || [ -z "${WP_TITLE:-}" ] || \
	   [ -z "${WP_ADMIN_USER:-}" ] || [ -z "${WP_ADMIN_PASSWORD:-}" ] || \
	   [ -z "${WP_ADMIN_EMAIL:-}" ] || [ -z "${WP_USER:-}" ] || \
	   [ -z "${WP_USER_EMAIL:-}" ]; then
		echo "Required environment variables are not set."
		exit 1
	fi

	wp core download --allow-root

	wp core config \
		--dbname="${SQL_DATABASE}" \
		--dbuser="${SQL_USER}" \
		--dbpass="$(cat /run/secrets/db_password)" \
		--dbhost="mariadb" \
		--allow-root

	wp core install \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--allow-root

	wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
		--role=author \
		--user_pass="$(cat /run/secrets/wp_password)" \
		--allow-root
fi

exec /usr/sbin/php-fpm7.4 -F
