FROM debian:11.0

WORKDIR /app

COPY /tools/launch.sh /app/tools/launch.sh

RUN apt update && apt upgrade && apt-get install mariadb-server -y \
	&& chmod 777 /app/tools/launch.sh

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

CMD ["sh", "/app/tools/launch.sh"]
