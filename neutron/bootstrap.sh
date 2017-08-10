#!/bin/bash

set -eux

function bootstrap {
    neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head
}

while [[ ! -f /var/log/${PROJECT}/chown ]]; do
    sleep 1
done

if [[ ${NEUTRON_BOOTSTRAP} == 1 ]]; then
    bootstrap
fi

touch /var/log/${PROJECT}/bootstrap
