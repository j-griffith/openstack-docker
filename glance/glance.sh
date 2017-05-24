#!/bin/bash

set -eux

service=$1
pid=

trap "kill -TERM $pid" INT TERM HUP

while [[ ! -f /var/log/${PROJECT}/bootstrap ]]; do
    sleep 1
done

${service} --config-file /etc/openstack/global.conf --config-file /etc/${PROJECT}/${PROJECT}.conf --config-file /etc/${PROJECT}/${service}.conf --log-file /var/log/${PROJECT}/${service}.log &

pid=$!

wait $pid
trap - INT TERM HUP
wait $pid
