#!/bin/bash
set -e

shutdown() {
    kill -3 $(ps -aux | grep /usr/bin/supervisord | head -n1 | awk '{print $2}')
    wait $!
}

trap 'shutdown' SIGTERM
trap 'shutdown' SIGQUIT

exec /usr/bin/supervisord --nodaemon -c /www/docker/conf/supervisord-php-fpm-nginx.conf

exec "$@"
wait $!
