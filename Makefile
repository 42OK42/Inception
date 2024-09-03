.PHONY: all build up down clean

all: build up

build:
	sudo docker-compose -f docker-compose.yml build

up:
	sudo docker-compose -f docker-compose.yml up -d

down:
	sudo docker-compose -f docker-compose.yml down

clean: down
	sudo docker-compose -f docker-compose.yml rm -f
	sudo docker system prune -f