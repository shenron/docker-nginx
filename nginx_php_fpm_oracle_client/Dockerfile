FROM shenron/nginx:1.10.2

MAINTAINER Thomas CASTELLY <thomas@tcy.io>

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
COPY /conf/nginx/upstream.conf /etc/nginx/conf.d/upstream.conf
COPY /conf/nginx/static-php.conf /etc/nginx/conf.d/static-php.conf

# Copy base PHP config
COPY /conf/php/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY /conf/php/php.ini /etc/php5/fpm/php.ini
COPY /conf/php/php-fpm.conf /etc/php5/fpm/php-fpm.conf

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
RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8-1.4.10
RUN echo "extension=oci8.so" >> /etc/php5/fpm/php.ini

# Install other extensions
RUN pecl install\
    xdebug\
    memcached\
    zip

# Install PHPUnit
RUN wget https://phar.phpunit.de/phpunit.phar 

RUN chmod +x phpunit.phar

RUN mv phpunit.phar /usr/local/bin/phpunit

COPY /conf/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www

EXPOSE 80 443
