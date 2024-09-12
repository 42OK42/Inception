.PHONY: all clean build up down logs restart init stop start status

all: build up

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	@echo "Cleaning up..."
	docker system prune -af

logs:
	docker-compose -f srcs/docker-compose.yml logs -f

re: down up

# Initialize data folder, credentials and environment (without starting)
init:
	@echo "Initializing Files and Credentials..."
	@./srcs/init.sh
	@echo "Initialization complete"

# Stop all running containers
stop:
	@echo "Stopping all containers..."
	docker stop $$(docker ps -q) > /dev/null 2>&1 || true
	@echo "Containers stopped"

# Start stopped containers
start:
	@echo "Starting stopped containers..."
	docker-compose -f srcs/docker-compose.yml start
	@echo "Containers started"

# Show status of all containers
status:
	@echo "IMAGES OVERVIEW"
	@docker images
	@echo "CONTAINER OVERVIEW"
	@docker ps -a
	@echo "NETWORK OVERVIEW"
	@docker network ls
	@echo "CONTAINER LOGS"
	@docker-compose -f srcs/docker-compose.yml logs