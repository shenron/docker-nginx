FROM shenron/nginx:1.10.3

MAINTAINER Thomas CASTELLY <thomas@tcy.io>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    # For memcached
    pkg-config \ 
    php5-dev \
    php5-fpm \
    php-pear \
    unzip \
    libaio-dev \
    libmemcached-dev \
    zlib1g-dev \
    unzip \
    wget

# Copy link config between PHP and Nginx
COPY /conf/nginx/ /etc/nginx/conf.d/

# Copy base PHP config
COPY /conf/php/ /etc/php5/fpm/

# Copy link config between PHP and Nginx
COPY /conf/nginx/ /etc/nginx/conf.d/

# install oracle client
COPY /conf/oracle/ /tmp/

RUN unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /usr/local/ && \
  unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /usr/local/ && \
  unzip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /usr/local/ && \
  ln -s /usr/local/instantclient_12_1 /usr/local/instantclient && \
  ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so && \
  ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus && \
  rm /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip &&\
  echo 'instantclient,/usr/local/instantclient' | pecl install oci8-1.4.10 && \
  echo "extension=oci8.so" >> /etc/php5/fpm/php.ini

# Install other extensions
RUN pecl install\
  xdebug\
  memcached-2.2.0 \
  zip

# Install PHPUnit
RUN wget https://phar.phpunit.de/phpunit.phar && \ 
  chmod +x phpunit.phar && \
  mv phpunit.phar /usr/local/bin/phpunit

COPY /conf/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www

EXPOSE 80 443
