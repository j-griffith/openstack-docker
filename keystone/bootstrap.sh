#!/bin/bash

set -eux

function bootstrap {
    keystone-manage --config-file /etc/openstack/global.conf --config-file /etc/keystone/keystone.conf db_sync

    export OS_BOOTSTRAP_ADMIN_URL=${LB_URI}:5000/v3
    export OS_BOOTSTRAP_INTERNAL_URL=${LB_URI}:5000/v3
    export OS_BOOTSTRAP_PUBLIC_URL=${LB_URI}:5000/v3
    keystone-manage --config-file /etc/openstack/global.conf --config-file /etc/keystone/keystone.conf bootstrap
}

while [[ ! -f /var/log/${PROJECT}/chown ]]; do
    sleep 1
done

if [[ ${KEYSTONE_BOOTSTRAP} == 1 ]]; then
    bootstrap
fi

touch /var/log/${PROJECT}/bootstrap
