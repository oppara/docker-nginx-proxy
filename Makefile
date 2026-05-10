SHELL := /bin/bash

DOCKER_NETWORK_NAME := nginx-proxy
CERT_NAME := dev.test
CERT_DIR := ./certs
CERT_DOMAIN := *.$(CERT_NAME)
CERT_KEY := $(CERT_DIR)/$(CERT_NAME).key
CERT_CRT := $(CERT_DIR)/$(CERT_NAME).crt

All: help

.PHONY: up
up: ## Docker ネットワークを作成し、コンテナを起動します。
	@docker network inspect $(DOCKER_NETWORK_NAME) >/dev/null 2>&1 || docker network create $(DOCKER_NETWORK_NAME)
	@docker compose up -d

.PHONY: down
down: ## Docker ネットワークとコンテナを削除します。
	@docker compose down
	@docker network rm $(DOCKER_NETWORK_NAME) 2>/dev/null || :

.PHONY: destroy
destroy: ## イメージ、ボリュームも含め全て削除
	@docker compose down -v --rmi all
	@docker network rm $(DOCKER_NETWORK_NAME) 2>/dev/null || :

.PHONY: rebuild
reload: ## イメージ、ボリュームも含め全て削除し、再度ネットワークを作成し、コンテナを起動します。
	@make destroy
	@make up

.PHONY: cert
cert: ## dev.test 用のローカル証明書を作成します。
	@CAROOT="$$(mkcert -CAROOT)"; \
	if [ ! -f "$$CAROOT/rootCA.pem" ] || [ ! -f "$$CAROOT/rootCA-key.pem" ]; then \
		mkcert -install; \
	fi
	@mkcert -key-file "$(CERT_KEY)" -cert-file "$(CERT_CRT)" "$(CERT_NAME)" "$(CERT_DOMAIN)"

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
