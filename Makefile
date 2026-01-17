all: up

up:
	mkdir -p /home/herakoto/data/mariadb /home/herakoto/data/wordpress
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

stop:
	docker compose -f srcs/docker-compose.yml stop

start:
	docker compose -f srcs/docker-compose.yml start

clean: down
	docker system prune -af

fclean: clean
	docker volume prune -f

re: fclean all

.PHONY: all up down stop start clean fclean re
