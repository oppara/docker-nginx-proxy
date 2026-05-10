# docker-nginx-proxy

[日本語](./README.ja.md)

This repository uses [nginx-proxy](https://hub.docker.com/r/nginxproxy/nginx-proxy) to run multiple containers and make them accessible over HTTPS via FQDNs.

Example:

- Accessing `https://blog.dev.test` routes to the container started from `/home/work/blog/compose.yaml`
- Accessing `https://api.dev.test` routes to the container started from `/home/work/api/compose.yaml`

## Requirements

- Docker / Docker Compose
- [mkcert](https://github.com/FiloSottile/mkcert)
- make

## Setup

For example, to access `https://hoge.dev.test`:

### 1. Start `nginx-proxy`

```shell
% git clone git@github.com:oppara/docker-nginx-proxy.git
% cd docker-nginx-proxy
% make up
% make cert # only for the initial setup
```

### 2. Create `compose.yaml`

- Set `VIRTUAL_HOST`
- Use the `nginx-proxy` network

Example `compose.yaml`:

```yaml:compose.yaml
services:
  hoge:
    image: httpd:2.4
    container_name: hoge
    expose:
      - 80
    restart: always
    environment:
      VIRTUAL_HOST: hoge.dev.test

networks:
  default:
    name: nginx-proxy
    external: true
```

### 3. Update your hosts file

Add the FQDN configured in `VIRTUAL_HOST` to your hosts file.

```shell
127.0.0.1 localhost
127.0.0.1 hoge.dev.test
```

### 4. Start the container

```shell
% docker compose up -d
```

### 5. Open it in your browser

```shell
% open https://hoge.dev.test
```

## SSL certificates

This repository uses [mkcert](https://github.com/FiloSottile/mkcert) to generate local SSL certificates and keys.

On the first `make cert`, `mkcert -install` runs only when no local CA exists yet.

If the certificate expires, recreate it with:

```shell
% make cert
```

## Extras

### Mailpit

[Mailpit](https://github.com/axllent/mailpit) lets you inspect emails sent from your local environment in a web UI (`http://0.0.0.0:8025`).

For a Mailpit sample, see [mailpit-sample/README.md](./mailpit-sample/README.md).
