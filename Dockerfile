# Gunakan PHP 8.3 dengan FPM
FROM php:8.3-fpm

# Perbarui repository paket
RUN apt-get update \
    && apt-get install -y \
        git \
        libzip-dev \
        zip \
        unzip \
        npm \
        curl \
        nginx \
        certbot \
        python3-certbot-nginx \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instal Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instal GitLab Runner
RUN curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 \
    && chmod +x /usr/local/bin/gitlab-runner

# Konfigurasi Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Direktori kerja aplikasi
WORKDIR /var/www/html

# Ekspose port untuk Nginx
EXPOSE 80
EXPOSE 443

# Perintah untuk memulai Nginx dan PHP-FPM
CMD ["/bin/bash", "-c", "service php8.3-fpm start && nginx -g 'daemon off;'"]
