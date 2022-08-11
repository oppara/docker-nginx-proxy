<?php
declare(strict_types=1);

define('SELF_URL', 'http://' . $_SERVER['SERVER_NAME']);
define('MAILCATCHER_URL', 'http://' . $_SERVER['SERVER_NAME'] . ':1080');

if (isset($_POST['send_mail'])) {

    $to = 'foo@example.com';
    $subject = 'MailCatcher のテスト';
    $message = 'これは MailCatcher のテストです。';
    $headers = [
        'From' => 'noreply@example.com'
    ];

    mb_language('Japanese');
    mb_internal_encoding('UTF-8');
    if (mb_send_mail($to, $subject, $message, $headers)) {
        header('Location: ' . SELF_URL);
    } else {
        var_dump('ERROR mb_send_mail');
    }
}
?>

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Try MailCatcher</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
  </head>

  <body>
    <div class="container-fluid">
      <main>
        <div class="row" style="margin: 1rem">
          <form method="post">
            <div class="form-group">
              <button type="submit" class="btn btn-primary">テストメール送信</button>
              <input type="hidden" name="send_mail" value="1" />
            </div>
            <div class="form-group">
              <a href="<?php echo MAILCATCHER_URL; ?>" class="btn btn-light" role="button" target="_blank">MailCatcher を開く</a>
            </div>
          </form>
        </div>
      </main>
    </div>
  </body>
</html>

