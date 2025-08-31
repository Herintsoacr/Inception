#!bin/bash

DB_ROOT_PASSWORD = $(cat /run/secrets/db_root_password)
DB_USER_PASSWORD = $(cat /run/secrets/db_user_password)

exec mysqld;

until mysqladmin ping -u root -p${DB_ROOT_PASSWORD} --silent; do
	sleep 1
done

mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE ${DATABASE_NAME}; \
			CREATE USER ${DATABASE_USERNAME}@'localhost' IDENTIFIED BY ${DB_USER_PASSWORD}; \
			GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO ${DATABASE_USERNAME}@'localhost'; \
			FLUSH PRIVILEGES;"

mysqladmin shutdown -u root -p${DB_ROOT_PASSWORD}

exec mysqld;
