FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx curl openssl

RUN mkdir -p /etc/nginx/ssl && chmod 755 /etc/nginx/ssl &&\
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=tviejo.42.fr/UID=tviejo"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html/ && chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]