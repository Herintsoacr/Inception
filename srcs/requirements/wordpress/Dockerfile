FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY ./tools/launch.sh /usr/local/bin/launch.sh
RUN chmod +x /usr/local/bin/launch.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/launch.sh"]
