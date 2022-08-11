SHELL := /bin/bash

DOCKER_IMAGE_NAME := jwilder/nginx-proxy
DOCKER_NETWORK_NAME := nginx-proxy

All: help

.PHONY: up
up: ## Docker ネットワークを作成し、コンテナを起動します。
	@docker network rm $(DOCKER_NETWORK_NAME) 2>/dev/null || :
	@docker network create $(DOCKER_NETWORK_NAME)
	@docker-compose up -d

.PHONY: down
down: ## Docker ネットワークとコンテナを削除します。
	@docker-compose down
	@docker network rm $(DOCKER_NETWORK_NAME) 2>/dev/null || :

.PHONY: destroy
destroy: ## Docker イメージを削除します。
	@docker rmi $(DOCKER_IMAGE_NAME)

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
