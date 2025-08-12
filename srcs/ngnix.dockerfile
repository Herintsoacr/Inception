FROM Debian:12.0
WORKDIR /app

COPY . .
RUN apt -y update; apt -y install wget; apt install curl gnupg2 ca-certificates lsb-release debian-archive-keyring; curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null;
