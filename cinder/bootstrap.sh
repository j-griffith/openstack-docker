#!/bin/bash

set -eux

function bootstrap {
    cinder-manage --config-file /etc/openstack/global.conf --config-file /etc/cinder/cinder.conf --config-file /etc/cinder/cinder-api.conf db sync
}

while [[ ! -f /var/log/${PROJECT}/chown ]]; do
    sleep 1
done

if [[ ${CINDER_BOOTSTRAP} == 1 ]]; then
    bootstrap
fi

touch /var/log/${PROJECT}/bootstrap
