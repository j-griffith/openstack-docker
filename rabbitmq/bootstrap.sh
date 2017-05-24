#!/bin/bash

set -eux

function bootstrap {
    echo ${RABBITMQ_COOKIE} > /var/lib/rabbitmq/.erlang.cookie
    chmod 0400 /var/lib/rabbitmq/.erlang.cookie
}

while [[ ! -f /var/log/rabbitmq/chown ]]; do
    sleep 1
done

if [[ ${RABBITMQ_BOOTSTRAP} == 1 ]]; then
    bootstrap
fi

touch /var/log/rabbitmq/bootstrap
