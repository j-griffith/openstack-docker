#!/bin/bash

set -eux

function bootstrap {
    #nova-manage --config-file /etc/openstack/global.conf --config-file /etc/nova/nova.conf --config-file /etc/nova/nova-api.conf api_db sync
    #nova-manage --config-file /etc/openstack/global.conf --config-file /etc/nova/nova.conf --config-file /etc/nova/nova-api.conf cell_v2 map_cell0
    #nova-manage --config-file /etc/openstack/global.conf --config-file /etc/nova/nova.conf --config-file /etc/nova/nova-conductor.conf cell_v2 map_cell0
    #nova-manage --config-file /etc/openstack/global.conf --config-file /etc/nova/nova.conf --config-file /etc/nova/nova-conductor.conf cell_v2 create_cell --name=cell1 --verbose
    #nova-manage --config-file /etc/openstack/global.conf --config-file /etc/nova/nova.conf --config-file /etc/nova/nova-api.conf cell_v2 create_cell --name=cell1 --verbose
    nova-manage --config-file /etc/openstack/global.conf --config-file /etc/nova/nova.conf --config-file /etc/nova/nova-api.conf api_db sync
    nova-manage cell_v2 simple_cell_setup
    nova-manage --config-file /etc/openstack/global.conf --config-file /etc/nova/nova.conf --config-file /etc/nova/nova-conductor.conf db sync
}

while [[ ! -f /var/log/${PROJECT}/chown ]]; do
    sleep 1
done

if [[ ${NOVA_BOOTSTRAP} == 1 ]]; then
    bootstrap
fi

touch /var/log/${PROJECT}/bootstrap
