# MailCatcher を使用した例

- テストメール送信ページの URL: http://foo.example.local
- MailCatcher の URL: http://foo.example.local:1080

## 前準備

1. `nginx-proxy` は立ち上げておく。
1. `foo.example.local` を hosts に設定しておく。


```
127.0.0.1 localhost foo.example.local
```

## 手順


### 1. コンテナの起動

コンテナを起動する。

```
% make up
```

### 2. ブラウザでアクセス

http://foo.example.local へブラウザでアクセスし、[テストメール送信] ボタンをクリック。

### 3. MailCatcher の確認

http://foo.example.local:1080 へブラウザでアクセスし、メールが受信できているか確認する。


### 4. 後片付け

コンテナを終了する。

```
% make down
```

イメージを削除する。

```
% make destroy
```
