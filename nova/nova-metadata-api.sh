#!/bin/bash

set -eux

pid=

trap "kill -TERM $pid" INT TERM HUP

while [[ ! -f /var/log/${PROJECT}/bootstrap ]]; do
    sleep 1
done

nova-api --config-file /etc/${PROJECT}/nova.conf --config-file /etc/${PROJECT}/nova-metadata-api.conf &

pid=$!

wait $pid
trap - INT TERM HUP
wait $pid
