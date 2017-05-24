#!/bin/bash

set -eux

trap 'pkill -u rabbitmq-server -15' SIGINT SIGTERM SIGHUP

while [[ ! -f /var/log/rabbitmq/bootstrap ]]; do
    sleep 1
done

rabbitmq-server &

wait
