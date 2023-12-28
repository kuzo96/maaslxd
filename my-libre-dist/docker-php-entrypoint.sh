#!/bin/sh
set -e

#tar -xf /librenms.tar.gz -C /opt --skip-old-files && ls /opt
#php-fpm8.1 &
cron -f /etc/cron.d/librenms &
cat /vault/secrets/librenms >> /data/.env && cp /data/.env /opt/librenms &
/opt/librenms/discovery.php -h new >> /dev/null 2>&1 &
/opt/librenms/cronic /opt/librenms/poller-wrapper.py 16 &
cd /opt/librenms
env php artisan schedule:run --no-ansi --no-interaction &
tail -f /dev/null
