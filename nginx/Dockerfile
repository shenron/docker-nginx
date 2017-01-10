FROM nginx:1.10.2

MAINTAINER Thomas CASTELLY <thomas@tcy.io>

RUN rm -f /etc/nginx/conf.d/*
COPY /conf/h5bp /etc/nginx/h5bp
COPY /conf/nginx.conf /etc/nginx/nginx.conf
COPY /conf/fastcgi_params /etc/nginx/fastcgi_params
COPY /conf/fastcgi_api /etc/nginx/fastcgi_api
COPY /conf/mime.types /etc/nginx/mime.types
COPY /conf/gzip.conf /etc/nginx/gzip.conf

RUN mkdir /etc/nginx/logs
RUN touch /etc/nginx/logs/static.log

RUN mkdir /tmp/nginx

EXPOSE 80 443
