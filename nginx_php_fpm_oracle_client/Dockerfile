FROM shenron/nginx:1.10.2

MAINTAINER Thomas CASTELLY <thomas@tcy.io>

# Force to install PHP7
RUN apt-get update && apt-get -y install apt-transport-https curl lsb-release ca-certificates wget &&\
  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg &&\
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
    # For memcached
    pkg-config \ 
    php7.1-xml \
    php7.1-dev \
    php7.1-fpm \
    php-pear \
    unzip \
    libaio-dev \
    libmemcached-dev \
    zlib1g-dev \
    unzip

# Copy link config between PHP and Nginx
COPY /conf/nginx/upstream.conf /etc/nginx/conf.d/upstream.conf
COPY /conf/nginx/static-php.conf /etc/nginx/conf.d/static-php.conf

# Copy base PHP config
COPY /conf/php/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY /conf/php/php.ini /etc/php/7.1/fpm/php.ini
COPY /conf/php/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf

# install oracle client
COPY /conf/oracle/instantclient-basic-linux.x64-12.1.0.2.0.zip /tmp/
COPY /conf/oracle/instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/
COPY /conf/oracle/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip /tmp/

RUN unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /usr/local/

RUN ln -s /usr/local/instantclient_12_1 /usr/local/instantclient
RUN ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so
RUN ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus
RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8
RUN echo "extension=oci8.so" >> /etc/php/7.1/fpm/php.ini

# Install other extensions
RUN pecl install\
    xdebug\
    # memcached\
    zip

# Today the install of memcached with pecl not working with php7
# Install it manually
RUN apt-get install -y git &&\
    cd / &&\
    git clone https://github.com/php-memcached-dev/php-memcached.git &&\
    cd php-memcached &&\
    phpize &&\
    ./configure --disable-memcached-sasl &&\
    make &&\
    make install

# Install PHPUnit
RUN wget https://phar.phpunit.de/phpunit.phar 

RUN chmod +x phpunit.phar

RUN mv phpunit.phar /usr/local/bin/phpunit

COPY /conf/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www

EXPOSE 80 443
