.PHONY: all clean build up down logs restart

all: build up

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af

logs:
	docker-compose -f srcs/docker-compose.yml logs -f

restart: down up