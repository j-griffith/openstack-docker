#!/bin/bash

set -eux

trap "pkill -f uwsgi -2" SIGINT SIGTERM SIGHUP

while [[ ! -f /var/log/${PROJECT}/bootstrap ]]; do
    sleep 1
done

OS_KEYSTONE_CONFIG_FILES="/etc/openstack/global.conf;/etc/keystone/keystone.conf"

uwsgi --wsgi-file $(find /usr -path \*bin/keystone-wsgi-public) --http 10.10.1.1:5000 --so-keepalive --http-keepalive &

wait
