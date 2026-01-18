#!/bin/bash

DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_USER_PASSWORD=$(cat /run/secrets/db_user_password)

# Initialize database directory if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --ldata=/var/lib/mysql > /dev/null
fi

# Start temporary server without networking to run setup
mysqld_safe --datadir=/var/lib/mysql --skip-networking &
until mysqladmin ping --silent; do
    sleep 1
done

mysql -u root <<SQL
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
SQL

mysqladmin -uroot -p"${DB_ROOT_PASSWORD}" shutdown

exec mysqld_safe --datadir=/var/lib/mysql

