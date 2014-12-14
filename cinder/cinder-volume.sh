#!/bin/bash

set -eux

#trap 'pkill -f uwsgi -2' SIGINT SIGTERM SIGHUP

#uwsgi --wsgi-file /usr/local/bin/keystone-wsgi-public --http :5000 --so-keepalive --http-keepalive &

#wait

cinder-volume --config-file /etc/cinder/cinder.conf --log-file /var/log/cinder/cinder-volume.log
