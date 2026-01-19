#!/bin/bash

DB_PASSWORD=$(cat /run/secrets/db_user_password)
WP_PASSWORDS=$(cat /run/secrets/wp_root_password)
WP_USER_PASS=$(cat /run/secrets/user_wp_password)

if [ ! -f wp-config.php ]; then
	wp core download --allow-root

	wp config create \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PASSWORD \
    --dbhost=$DB_HOST \
	--allow-root \
    --skip-check \

	wp core install \
  --url=$DOMAIN_NAME \
  --title="Inception" \
  --admin_user=$WP_USERNAME \
  --admin_password=$WP_PASSWORDS \
  --admin_email=$WP_ADMIN_MAIL \
  --allow-root \

	wp user create $WP_USER $WP_EMAIL \
  --role=editor \
  --allow-root \
  --user_pass=$WP_USER_PASS
fi

exec /usr/sbin/php-fpm8.2 -F
