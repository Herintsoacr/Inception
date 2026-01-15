#!/bin/bash
set -euo pipefail

DB_HOST=${DB_HOST:-mariadb}
DB_NAME=${DATABASE_NAME:-wordpress}
DB_USER=${DATABASE_USERNAME:-wp_user}
DB_PASSWORD=$(cat /run/secrets/db_user_password)

PHP_FPM_CONF="/etc/php/8.2/fpm/pool.d/www.conf"
if [ -f "$PHP_FPM_CONF" ]; then
    sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' "$PHP_FPM_CONF"
fi

if [ ! -f /var/www/html/wp-config.php ]; then
    curl -sSL https://wordpress.org/latest.tar.gz -o /tmp/wordpress.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /tmp
    rm -rf /var/www/html/*
    cp -a /tmp/wordpress/* /var/www/html/
    rm -rf /tmp/wordpress /tmp/wordpress.tar.gz

    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/${DB_NAME}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${DB_USER}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${DB_PASSWORD}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${DB_HOST}/" /var/www/html/wp-config.php

    chown -R www-data:www-data /var/www/html
fi

exec php-fpm8.2 -F
