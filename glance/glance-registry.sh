#!/bin/bash

set -eux

#trap 'pkill -f uwsgi -2' SIGINT SIGTERM SIGHUP

#uwsgi --wsgi-file /usr/local/bin/keystone-wsgi-public --http :5000 --so-keepalive --http-keepalive &

#wait

glance-registry --config-file /etc/glance/glance-registry.conf --log-file /var/log/glance/glance-registry.log
