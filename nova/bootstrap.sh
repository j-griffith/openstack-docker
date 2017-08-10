#!/bin/bash

set -eux

function bootstrap {
    nova-manage api_db sync
    nova-manage cell_v2 map_cell0
    nova-manage cell_v2 create_cell --name=cell1 --verbose
    nova-manage db sync
}

while [[ ! -f /var/log/${PROJECT}/chown ]]; do
    sleep 1
done

if [[ ${NOVA_BOOTSTRAP} == 1 ]]; then
    bootstrap
fi

touch /var/log/${PROJECT}/bootstrap
