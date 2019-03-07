#!/usr/bin/env bash
.PHONY: help build start stop composer dbmigrate cc permission ngrok

default: help

build: ## Build containers
	docker volume create --name=symfony-sync
	docker-compose build
	docker-compose up -d
	-docker-sync start
	
start: ## Start development: clear cache / dbmigrate / generate assets
	docker-compose up -d
	-docker-sync start
	$(MAKE) permission
	$(MAKE) composer
	@-script/exec php bin/console doctrine:database:create >/dev/null
	$(MAKE) dbmigrate
	$(MAKE) cc

stop: ## Stop the Docker containers
	docker-compose stop
	docker-sync stop

composer: ## Run composer install
	script/exec composer install --no-interaction

dbmigrate: ## Run db migration
	@-script/exec php bin/console doc:mig:mig -n

cc: ## Clear cache
	script/exec php bin/console cache:clear
	script/exec php bin/console cache:clear --env=prod --no-debug
	$(MAKE) permission

permission: ## Set permission on cache, logs
	docker exec -it -u 0 symfony_php sh /run.sh

ngrok: ## Start ngrok server
	docker run --network `docker network ls -f name=symfony -q` --rm -it --link symfony_apache wernight/ngrok ngrok http symfony_apache:80

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
