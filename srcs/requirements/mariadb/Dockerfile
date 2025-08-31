FROM debian:bookworm

COPY ./tools/launch.sh /usr/local/bin/launch.sh

RUN apt update && apt upgrade && apt-get install mariadb-server -y \
	&& chmod 777 /app/tools/launch.sh

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["/usr/local/bin/launch.sh"]
