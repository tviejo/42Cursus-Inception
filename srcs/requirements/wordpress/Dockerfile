FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y net-tools
RUN apt-get install -y php7.4-fpm curl php-mysql mariadb-client

RUN mkdir -p /run/php && chmod 755 /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod 755 /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod 755 /usr/local/bin/script.sh

EXPOSE 9000

WORKDIR /var/www/html

CMD ["sh", "/usr/local/bin/script.sh"]
