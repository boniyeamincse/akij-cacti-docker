# Base image for PHP and Apache
FROM php:8.1-apache

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    rrdtool \
    snmp \
    libpng-dev \
    libxml2-dev \
    librrds-perl \
    unzip \
    mariadb-client \
    git \
    && docker-php-ext-install mysqli

# Enable Apache modules
RUN a2enmod rewrite && a2enmod ssl

# Download Cacti
RUN git clone https://github.com/Cacti/cacti.git /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Set timezone
ENV TZ=UTC
RUN echo "date.timezone = ${TZ}" > /usr/local/etc/php/php.ini

# Expose the default web port
EXPOSE 80
