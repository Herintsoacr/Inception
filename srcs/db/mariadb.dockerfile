FROM debian:12.0
WORKDIR /db

COPY . .
RUN apt update; apt upgrade; apt install mariadb-server -y;
