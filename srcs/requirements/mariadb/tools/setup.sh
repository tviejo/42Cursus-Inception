#!/bin/bash

# Start the MariaDB service
service mysql start

# Secure the installation and create the database and user
mysql_secure_installation <<EOF

y
${MYSQL_ROOT_PASSWORD}
${MYSQL_ROOT_PASSWORD}
y
n
y
y
EOF

mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
CREATE DATABASE ${MYSQL_DATABASE};
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop the MariaDB service
service mysql stop

# Start MariaDB in safe mode
exec mysqld_safe
