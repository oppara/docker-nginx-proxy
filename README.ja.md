# docker-nginx-proxy

[nginx-proxy](https://hub.docker.com/r/nginxproxy/nginx-proxy) を使って複数のコンテナを立ち上げ、FQDN で HTTPS アクセスできるようにしたい。

こんなイメージ

- `https://blog.dev.test` にアクセスすると `/home/work/blog/compose.yaml` で起動したコンテナにルーティングされる
- `https://api.dev.test` にアクセスすると `/home/work/api/compose.yaml` で起動したコンテナにルーティングされる

## 前提条件

- Docker / Docker Compose
- [mkcert](https://github.com/filosottile/mkcert)
- make

## 手順

https://hoge.dev.test でアクセスする場合。

### 1. `nginx-proxy` を立ち上げておく

```shell
% git clone git@github.com:oppara/docker-nginx-proxy.git 
% cd docker-nginx-proxy
% make cert # 初回セットアップ時のみ
% make up
```

### 2. compose.yaml を書く

- `VIRTUAL_HOST` を設定する。
- `networks` で `nginx-proxy` を指定する。

compose.yaml 設定例

```yaml:compose.yaml
services:
  hoge:
    image: httpd:2.4
    container_name: hoge
    expose:
      - 80
    restart: always
    environment:
      # `VIRTUAL_HOST` を設定する。
      VIRTUAL_HOST: hoge.dev.test

# `networks` で `nginx-proxy` を指定する。
networks:
  default:
    name: nginx-proxy
    external: true
```

### 3. hosts を設定する

compose.yaml の `VIRTUAL_HOST` を設定した FQDN を `hosts` に設定する。

```shell
127.0.0.1 localhost
127.0.0.1 hoge.dev.test
```

### 4. コンテナを立ち上げる

```shell
% docker compose up -d
```

### 5. ブラウザでアクセスする

```shell
% open https://hoge.dev.test
```

## SSL 証明書

[mkcert](https://github.com/FiloSottile/mkcert) を使用して、ローカルで SSL を使用するための証明書と秘密鍵を作成し使用している。

初回の `make cert` では、ローカル CA がない場合のみ `mkcert -install` を実行してから証明書を生成。

証明書の有効期限が切れた場合は、以下のコマンドで証明書、秘密鍵を再作成すること。

```shell
% make cert
```

## おまけ

### Mailpit

[Mailpit](https://github.com/axllent/mailpit) を使うと、ローカル環境で送信したメールを Web UI (http://0.0.0.0:8025) で確認できる。

[Mailpit を使用したサンプル](./mailpit-sample/README.md)
