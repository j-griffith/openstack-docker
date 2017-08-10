#!/bin/bash

set -eux

service=$1
pid=

trap "kill -TERM $pid" INT TERM HUP

while [[ ! -f /var/log/${PROJECT}/bootstrap ]]; do
    sleep 1
done

${service} --config-file /etc/${PROJECT}/nova.conf --config-file /etc/${PROJECT}/${service}.conf &

pid=$!

wait $pid
trap - INT TERM HUP
wait $pid
