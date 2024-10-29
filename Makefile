# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yourlogin <yourlogin@student.42.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: YYYY/MM/DD HH:MM:SS by yourlogin        #+#    #+#              #
#    Updated: YYYY/MM/DD HH:MM:SS by yourlogin       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

all: up

up:
	docker-compose -f srcs/docker-compose.yml up --build -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af
	sudo rm -rf /home/thomas/data/db
	sudo rm -rf /home/thomas/data/wordpress

re: clean all

.PHONY: all up down clean re
