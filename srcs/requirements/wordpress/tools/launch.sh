#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

php wp-cli.phar --info

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

if [ ! -f wp-config.php ]; then
	wp config create \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="$DB_HOST" \
	--allow-root \
    --skip-check \

	wp core install \
  --url="$DOMAIN_NAME" \
  --title="Inception" \
  --admin_user=WP_USERNAME \
  --admin_password=$WP_PASSWORDS \
  --admin_email=WP_ADMIN_MAIL \
  --allow-root \

	wp user create $WP_USER $WP_EMAIL \
  --role=editor \
  --allow-root \
  --user_pass=WP_USER_PASS
fi


