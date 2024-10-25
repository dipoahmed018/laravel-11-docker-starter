FROM php:8.2-fpm-alpine3.20

RUN apk --update add ca-certificates
RUN apk --no-cache add shadow

# Install PHP extensions if necessary (uncomment for example extensions)
RUN docker-php-ext-install pdo_mysql

WORKDIR /var/www/html

EXPOSE 80

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


COPY scripts/php.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

CMD /bin/entrypoint.sh
