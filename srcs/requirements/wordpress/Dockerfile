# Use the penultimate stable version of Debian
FROM debian:buster-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    php7.3-fpm \
    php7.3-mysql \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create /var/www/html directory
RUN mkdir -p /var/www/html

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz

# Copy the startup script
COPY tools/setup.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/setup.sh

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["setup.sh"]
