#!bin/bash

DB_ROOT_PASSWORD = $(cat /run/secrets/db_root_password)
DB_USER_PASSWORD = $(cat /run/secrets/db_user_password)

exec mysql;

until mysqladmin ping &>/dev/null; do
	sleep 1
done

mysql -e "ALTER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}'; \
			CREATE DATABASE ${DATABASE_NAME}; \
			CREATE USER $DATABASE_USERNAME@'localhost' IDENTIFIED BY ${DB_USER_PASSWORD}; \
			GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO ${DATABASE_USERNAME}@'localhost'; \
			FLUSH PRIVILEGES;";

mysqladmin -u root -p shutdown;

exec mysql;
