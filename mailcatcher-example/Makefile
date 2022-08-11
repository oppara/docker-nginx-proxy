SHELL := /bin/bash


.PHONY: up
up: ## up
	docker-compose up -d

.PHONY: down
down: ## down
	docker-compose down

.PHONY: destory
destory: ## remove image
	docker rmi try_mailcatcher

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
