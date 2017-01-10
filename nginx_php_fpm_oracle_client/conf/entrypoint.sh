#!/usr/bin/env bash

# For DEV env, disabled opc cache
if [ "$ENV" == "DEV" ]; then
    sed -i "s/opcache.revalidate_freq=60/opcache.revalidate_freq=0/" /etc/php/7.1/fpm/php.ini
fi

/etc/init.d/php7.1-fpm start

exec "$@"
