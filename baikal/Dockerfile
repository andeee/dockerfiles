FROM php:5.6-apache

ENV VERSION   0.4.6
ENV CHECKSUM  d208b1c56fe145855a6c824112b15646

RUN apt-get update \
    && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysql pdo_mysql

RUN curl -fsSL -o baikal.zip https://github.com/fruux/Baikal/releases/download/$VERSION/baikal-$VERSION.zip \
    && echo "$CHECKSUM  baikal.zip" | md5sum -c - \
    && unzip baikal.zip -d /var/www/ \
    && rm baikal.zip \
    && chmod 755 /var/www/baikal \
    && chown -R www-data:www-data /var/www/baikal

COPY baikal.conf /etc/apache2/sites-available
RUN a2ensite baikal \
    && a2enmod rewrite

EXPOSE 80

VOLUME /var/www/baikal/Specific

CMD ["apache2-foreground"]
