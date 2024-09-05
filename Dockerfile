# PHP+Apache Image
FROM php:8.2-apache

# Set The Working Directory
WORKDIR /var/www/html

# Enable Mod Rewrite
RUN a2enmod rewrite

# Install Linux Libraries
RUN apt-get update && apt-get install -y \
    libmariadb-dev \
    libicu-dev \
    libxml2-dev \
    zlib1g-dev \
    libzip-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip

# Copy The Application Source Code to The Working Directory
COPY GeStock/ /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Composer Dependencies
RUN composer install

# Set The Document Root to The Public Directory
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Set permissions for The Application
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

# Expose Port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]