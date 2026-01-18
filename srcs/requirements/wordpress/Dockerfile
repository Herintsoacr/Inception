FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	php \
    php-fpm \
    php-mysql \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY ./tools/launch.sh /usr/local/bin/launch.sh
COPY ./conf/www.conf /usr/php/8.2/fpm/pool.d/www.conf

RUN chmod +x /usr/local/bin/launch.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& php wp-cli.phar --info \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/launch.sh"]
