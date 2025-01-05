# Base Image menggunakan PHP 8.3
FROM php:8.3-fpm

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/arista

# Copy project files
COPY . .

# Clone project dari GitHub
RUN git clone https://github.com/username/your-project.git .

# Install dependencies menggunakan Composer
RUN composer install --optimize-autoloader --no-dev

# Start PHP-FPM
CMD ["php-fpm"]
