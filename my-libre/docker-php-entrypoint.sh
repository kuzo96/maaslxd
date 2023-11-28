#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
#if [ "${1#-}" != "$1" ]; then
#       set -- /usr/sbin/php-fpm8.1 "$@"
#fi

#exec "$@"
tar -xf /librenms.tar.gz -C /opt &
tar -xf /mariadb.tar.gz -C /opt &
/usr/sbin/php-fpm8.1 &
/usr/sbin/nginx &
/usr/bin/mysqld_safe
/usr/sbin/syslog-ng &
/usr/sbin/cron -f /etc/cron.d/librenms &
cd /opt/librenms &
/usr/bin/env php artisan schedule:run --no-ansi --no-interaction &
tail -f /dev/null

