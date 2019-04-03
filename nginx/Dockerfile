FROM nginx:1.14.2

ARG CONFIG_VERSION=3.0.1

MAINTAINER Thomas CASTELLY <thomas@tcy.io>

RUN apt-get update && apt-get install -y wget

RUN cd /tmp && \
  wget https://github.com/h5bp/server-configs-nginx/archive/${CONFIG_VERSION}.tar.gz &&\
  tar -zxvf ${CONFIG_VERSION}.tar.gz && \
  cp -r server-configs-nginx-${CONFIG_VERSION}/* /etc/nginx/

COPY /conf/ /etc/nginx/

RUN mkdir /etc/nginx/logs
RUN touch /etc/nginx/logs/static.log

RUN mkdir /tmp/nginx

EXPOSE 80 443
