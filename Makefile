.PHONY: all clean build up down logs restart init stop start status

SECRETS_SCRIPT := ./srcs/initialize_secrets.sh
ENV_FILE := ./srcs/.env
SECRETS_DIR := ./secrets
DATA_DIR := ./data

all: build up

build: init
	docker-compose -f srcs/docker-compose.yml build

up: init
	docker-compose -f srcs/docker-compose.yml up -d

down:
	@docker-compose -f srcs/docker-compose.yml down || true

clean: down
	@echo "\e[34mCleaning up secrets, environment files, and data directories...\e[0m"
	@rm -fr $(SECRETS_DIR) || true
	@rm -fr $(ENV_FILE) || true
	@rm -fr $(DATA_DIR) || true
	@echo "\e[32mClean up complete\e[0m"
	@echo "\e[34mRemoving Docker volumes...\e[0m"
	@docker volume rm srcs_mariadb_data srcs_wordpress_files || true
	@echo "\e[34mPruning Docker system...\e[0m"
	@docker system prune --all --force
	@echo "\e[32mPrune complete\e[0m"

logs:
	docker-compose -f srcs/docker-compose.yml logs -f

re: down up

init:
	@echo "Initializing Files and Credentials..."
	@$(SECRETS_SCRIPT)
	@echo "Initialization complete"

stop:
	@echo "Stopping all containers..."
	docker stop $$(docker ps -q) > /dev/null 2>&1 || true
	@echo "Containers stopped"

start:
	@echo "Starting stopped containers..."
	docker-compose -f srcs/docker-compose.yml start
	@echo "Containers started"

status:
	@echo "IMAGES OVERVIEW"
	@docker images
	@echo "CONTAINER OVERVIEW"
	@docker ps -a
	@echo "NETWORK OVERVIEW"
	@docker network ls
	@echo "CONTAINER LOGS"
	@docker-compose -f srcs/docker-compose.yml logs