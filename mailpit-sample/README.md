# Mailpit sample

[日本語](./README.ja.md)

- Test mail page URL: https://try-mailpit.dev.test
- Mailpit URL: http://0.0.0.0:8025

## Prerequisites

1. Start `nginx-proxy` in advance.
1. Add `try-mailpit.dev.test` to your hosts file.

```hosts
127.0.0.1 try-mailpit.dev.test
```

## Steps

### 1. Start the container

Start the container.

```shell
% make up
```

### 2. Open it in your browser

Open https://try-mailpit.dev.test in your browser and click **Send test email**.

### 3. Check Mailpit

Open http://0.0.0.0:8025 in your browser and confirm that the email was received.

### 4. Clean up

Stop the container.

```shell
% make down
```

Remove the image.

```shell
% make destroy
```
