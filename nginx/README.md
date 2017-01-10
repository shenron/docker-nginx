# docker-nginx
## Extends official nginx with security and PHP compatibility

- h5bp base and securityfrom [server-config-nginx](https://github.com/h5bp/server-configs-nginx) server-config-nginx
- fastcgi to deserve PHP
- gzip for compress output (note: `gzip_min_length    256`, so if the file does not exceed the size, the output will not gziped)

## How use this image
Some examples are available, for more informations you can refer to official documentation [official documentation](https://hub.docker.com/_/nginx/) 
