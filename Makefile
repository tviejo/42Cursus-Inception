build:
	sudo mkdir -p /home/tviejo/data/mariadb && sudo mkdir -p /home/tviejo/data/wordpress
	cd srcs && docker compose up --build -d

down:
	cd srcs && docker compose down

up:
	cd srcs && docker compose up -d

clean:
	docker compose -f ./srcs/docker-compose.yml down

fclean: clean
	@- docker system prune -a -f
	@- docker volume rm mariadb wordpress
	@- sudo rm -rf /home/tviejo/data/mariadb
	@- sudo rm -rf /home/tviejo/data/wordpress

mariadb:
	@- docker exec -it mariadb /bin/bash		

rebuild: fclean build
