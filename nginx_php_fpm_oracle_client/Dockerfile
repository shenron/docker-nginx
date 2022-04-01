ARG NGINX_VERSION=1.20

FROM ghcr.io/shenron/nginx:${NGINX_VERSION}

MAINTAINER Thomas CASTELLY <thomas@tcy.io>

ENV DEBIAN_FRONTEND noninteractive

ENV LD_LIBRARY_PATH /usr/local/instantclient/

# Force to install PHP8
RUN apt-get update && apt-get -y install apt-transport-https curl lsb-release ca-certificates wget &&\
  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg &&\
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
  # For memcached
  pkg-config \
  php8.1-xml \
  php8.1-dev \
  php8.1-fpm \
  php8.1-curl \
  php-pear \
  unzip \
  libaio-dev \
  libmemcached-dev \
  libzip-dev \
  unzip

# Copy link config between PHP and Nginx
COPY /conf/nginx/ /etc/nginx/conf.d/

# Copy base PHP config
COPY /conf/php/ /etc/php/8.1/fpm/

# install oracle client
COPY /conf/oracle/ /tmp/

COPY ./install_oracle_driver.sh /tmp/

RUN /tmp/install_oracle_driver.sh

RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8 && \
  echo "extension=oci8.so" >> /etc/php/8.1/fpm/php.ini

# Install other extensions
RUN pecl install\
  xdebug-3.1.3\
  memcached\
  zip

# Install PHPUnit
RUN wget https://phar.phpunit.de/phpunit.phar &&\
  chmod +x phpunit.phar && \
  mv phpunit.phar /usr/local/bin/phpunit

COPY /conf/entrypoint-nginx-conf.sh /

COPY /conf/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www

EXPOSE 80 443
