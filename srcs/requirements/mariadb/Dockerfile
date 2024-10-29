# Use the penultimate stable version of Debian
FROM debian:buster-slim

# Install MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Copy the custom configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the startup script
COPY tools/setup.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/setup.sh

# Expose port 3306
EXPOSE 3306

# Start the database
CMD ["setup.sh"]
