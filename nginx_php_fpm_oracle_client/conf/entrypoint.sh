#!/usr/bin/env bash

PHP_V_PATH=8.4

if [ "$PHP_ENV" == "development" ]; then
  extFolder=$(php-config --extension-dir)
  echo "zend_extension=$extFolder/xdebug.so" >> /etc/php/$PHP_V_PATH/fpm/php.ini

  xdebugPath=/etc/php/8.4/fpm/conf.d/
  touch $xdebugPath/xdebug.ini

  # On linux it's possible to try to connect to the client
  # On MacOS X, the IP of host have to be set
  if [ -z "$IP_HOST" ]; then
    echo xdebug.discover_client_host=1 >> $xdebugPath/xdebug.ini
  else
    echo xdebug.discover_client_host=0 >> $xdebugPath/xdebug.ini
    echo "xdebug.remote_host=$IP_HOST" >> $xdebugPath/xdebug.ini
  fi

  echo xdebug.mode=debug >> $xdebugPath/xdebug.ini
  echo xdebug.start_with_request=0 >> $xdebugPath/xdebug.ini
  echo xdebug.client_port=9000 >> $xdebugPath/xdebug.ini
  echo xdebug.log=/tmp/php-xdebug.log >> $xdebugPath/xdebug.ini

  sed -i "s/opcache.revalidate_freq=60/opcache.revalidate_freq=0/" /etc/php/$PHP_V_PATH/fpm/php.ini
fi

sed -i "s/\$MEMCACHED_HOST/$MEMCACHED_HOST/g" /etc/php/$PHP_V_PATH/fpm/php.ini

/entrypoint-nginx-conf.sh

/etc/init.d/php8.4-fpm start

exec "$@"
