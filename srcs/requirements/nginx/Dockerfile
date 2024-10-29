# Use the penultimate stable version of Debian
FROM debian:buster-slim

# Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Set up an ARG for the domain name to be used in SSL generation
ARG DOMAIN_NAME

# Create the SSL directory
RUN mkdir -p /etc/nginx/ssl

# Copy NGINX configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Generate SSL certificate with the DOMAIN_NAME argument
RUN openssl req -x509 -nodes -days 365 \
    -subj "/C=FR/ST=France/L=Paris/O=42 School/OU=Student/CN=${DOMAIN_NAME}" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/${DOMAIN_NAME}.key \
    -out /etc/nginx/ssl/${DOMAIN_NAME}.crt

# Expose port 443
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]

