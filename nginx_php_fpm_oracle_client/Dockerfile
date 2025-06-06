ARG NGINX_VERSION=1.27

FROM ghcr.io/shenron/nginx:${NGINX_VERSION}

MAINTAINER Thomas CASTELLY <thomas@castelly.fr>

ENV MEMCACHED_HOST=memcached

ENV DEBIAN_FRONTEND noninteractive

ENV LD_LIBRARY_PATH /usr/local/instantclient/

# Force to install PHP8
RUN apt-get update && apt-get -y install apt-transport-https curl lsb-release ca-certificates wget &&\
  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg &&\
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
  # For memcached
  pkg-config \
  php8.4-xml \
  php8.4-dev \
  php8.4-fpm \
  php8.4-curl \
  php-pear \
  unzip \
  libaio-dev \
  libmemcached-dev \
  libzip-dev \
  unzip \
  \
  # fix pec libmemcached install
  libssl-dev

# fix php log persmissions
RUN touch /var/log/php-error.log && \
  chown www-data:www-data /var/log/php-error.log && \
  chmod 660 /var/log/php-error.log

# Copy link config between PHP and Nginx
COPY /conf/nginx/ /etc/nginx/conf.d/

# Copy base PHP config
COPY /conf/php/ /etc/php/8.4/fpm/

# install oracle client
COPY /conf/oracle/ /tmp/

COPY ./install_oracle_driver.sh /tmp/

RUN /tmp/install_oracle_driver.sh

# Install other extensions
RUN pecl install\
  xdebug-3.4.2\
  memcached\
  zip

RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8 && \
  echo "extension=oci8.so" >> /etc/php/8.4/fpm/php.ini

# Install PHPUnit
RUN wget https://phar.phpunit.de/phpunit.phar &&\
  chmod +x phpunit.phar && \
  mv phpunit.phar /usr/local/bin/phpunit

COPY /conf/entrypoint-nginx-conf.sh /

COPY /conf/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www

EXPOSE 80 443
