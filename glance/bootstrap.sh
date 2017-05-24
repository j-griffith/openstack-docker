#!/bin/bash

set -eux

function bootstrap {
    glance-manage --config-file /etc/glance/glance-registry.conf db_sync
}

while [[ ! -f /var/log/${PROJECT}/chown ]]; do
    sleep 1
done

if [[ ${GLANCE_BOOTSTRAP} == 1 ]]; then
    bootstrap
fi

touch /var/log/${PROJECT}/bootstrap
