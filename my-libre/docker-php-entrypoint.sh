#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
#if [ "${1#-}" != "$1" ]; then
#       set -- /usr/sbin/php-fpm8.1 "$@"
#fi

#exec "$@"
tar -xf /mariadb.tar.gz -C /opt && tar -xf /librenms.tar.gz -C /opt && ls
php-fpm8.1 &
nginx &
mysqld_safe &
syslog-ng &
cron -f /etc/cron.d/librenms &
cd /opt/librenms &
env php artisan schedule:run --no-ansi --no-interaction &
tail -f /dev/null

