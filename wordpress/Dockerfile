FROM debian:bullseye

RUN apt-get update && apt-get install -y php-fpm php-mysql curl tar

RUN mkdir -p /var/www/html && \
    curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

CMD ["php-fpm7.4", "-F"]
