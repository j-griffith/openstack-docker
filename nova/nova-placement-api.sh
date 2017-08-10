#!/bin/bash

set -eux

trap "pkill -f uwsgi -2" SIGINT SIGTERM SIGHUP

while [[ ! -f /var/log/${PROJECT}/bootstrap ]]; do
    sleep 1
done

uwsgi --wsgi-file /etc/nova/nova-placement-api-uwsgi.py --http 10.10.1.1:8778 &

wait
