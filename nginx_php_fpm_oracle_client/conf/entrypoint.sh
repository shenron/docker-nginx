#!/usr/bin/env bash

if [ "$PHP_ENV" == "development" ]; then
  extFolder=$(php-config --extension-dir)
  echo "zend_extension=$extFolder/xdebug.so" >> /etc/php/7.3/fpm/php.ini

  xdebugPath=/etc/php/7.3/fpm/conf.d/
  touch $xdebugPath/xdebug.ini

  # On linux it's possible to try to connect to the client
  # On MacOS X, the IP of host have to be set
  if [ -z "$IP_HOST" ]; then
    echo xdebug.remote_connect_back=1 >> $xdebugPath/xdebug.ini
  else
    echo xdebug.remote_connect_back=0 >> $xdebugPath/xdebug.ini
    echo "xdebug.remote_host=$IP_HOST" >> $xdebugPath/xdebug.ini
  fi

  echo xdebug.remote_enable=1 >> $xdebugPath/xdebug.ini
  echo xdebug.remote_autostart=0 >> $xdebugPath/xdebug.ini
  echo xdebug.remote_port=9000 >> $xdebugPath/xdebug.ini
  echo xdebug.remote_log=/tmp/php-xdebug.log >> $xdebugPath/xdebug.ini

  sed -i "s/opcache.revalidate_freq=60/opcache.revalidate_freq=0/" /etc/php/7.3/fpm/php.ini
fi

/entrypoint-nginx-conf.sh

/etc/init.d/php7.3-fpm start

exec "$@"
