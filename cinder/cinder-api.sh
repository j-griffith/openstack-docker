#!/bin/bash

set -eux

trap 'pkill -f uwsgi -2' SIGINT SIGTERM SIGHUP

uwsgi --wsgi-file /usr/local/bin/cinder-wsgi --http :8776 --so-keepalive --http-keepalive &

wait
