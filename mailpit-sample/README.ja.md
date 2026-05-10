# Mailpit のサンプル

- テストメール送信ページの URL: https://try-mailpit.dev.test
- Mailpit の URL: http://0.0.0.0:8025

## 前準備

1. `nginx-proxy` は立ち上げておく。
1. `try-mailpit.dev.test` を hosts に設定しておく。

```hosts
127.0.0.1 try-mailpit.dev.test
```

## 手順

### 1. コンテナの起動

コンテナを起動する。

```shell
% make up
```

### 2. ブラウザでアクセス

https://try-mailpit.dev.test へブラウザでアクセスし、[Send test email] ボタンをクリック。

### 3. Mailpit の確認

http://0.0.0.0:8025 へブラウザでアクセスし、メールが受信できているか確認する。

### 4. 後片付け

コンテナを終了する。

```shell
% make down
```

イメージを削除する。

```shell
% make destroy
```
