NAME = inception

all: up

up:
	sudo mkdir -p /home/thomas/data/mariadb
	sudo mkdir -p /home/thomas/data/wordpress
	sudo mkdir -p /var/www/html
	docker-compose -f srcs/docker-compose.yml up --build --force-recreate --no-deps -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af
	docker volume prune -f
	sudo rm -rf /home/thomas/data/mariadb
	sudo rm -rf /home/thomas/data/wordpress
	sudo rm -rf /var/www/html

re: clean all

.PHONY: all up down clean re
