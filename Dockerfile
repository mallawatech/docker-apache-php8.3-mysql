# Gunakan PHP 8.3 dengan Apache
FROM php:8.3-apache

# Perbarui repository paket
RUN apt-get update
RUN apt-get install -y git libzip-dev zip unzip npm curl && docker-php-ext-install pdo pdo_mysql zip && a2enmod rewrite
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instal Certbot untuk Let's Encrypt
RUN apt-get -y install certbot python3-certbot-apache
