# PHP-fpm

## Increase the maximum upload size

### nginx.conf

```
client_max_body_size 80M;
```

### php-fpm

php-fpm is responsible for uploading files. So you schould Increase
`upload_max_filesize` and `post_max_size`. But where to find these values.

-  create an `infophp()` file.
-  In this file you can see what php.ini file is loaded. It's the value for `Loaded Configuration File`
-  Update `upload_max_filesize` and `post_max_size`.
- Restart php-fpm ` systemctl start php71-php-fpm `
- Restart nginx
- verify these values by checking your `infophp()`.

## restart php-fpm

```
 systemctl start php71-php-fpm
```
