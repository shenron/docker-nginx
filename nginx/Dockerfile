FROM nginx:1.16.1

ARG CONFIG_VERSION=3.1.0

MAINTAINER Thomas CASTELLY <thomas@tcy.io>

ADD https://github.com/h5bp/server-configs-nginx/archive/${CONFIG_VERSION}.tar.gz /tmp

# retrieve h5bp and restore default conf
RUN cd /tmp && \
  mv /etc/nginx/conf.d . &&\
  tar -zxvf ${CONFIG_VERSION}.tar.gz && \
  cp -r server-configs-nginx-${CONFIG_VERSION}/* /etc/nginx/ &&\
  rm -rf /etc/nginx/conf.d && \
  mv /tmp/conf.d /etc/nginx &&\
  rm -rf /tmp/server-configs-nginx-${CONFIG_VERSION} &&\
  rm ${CONFIG_VERSION}.tar.gz

COPY /conf/ /etc/nginx/

RUN mkdir /etc/nginx/logs

RUN mkdir /tmp/nginx

EXPOSE 80 443
