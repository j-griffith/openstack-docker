#!/bin/bash

set -eux

trap 'mysqladmin -umysql shutdown' SIGINT SIGTERM SIGHUP

while [[ ! -f /var/log/mysql/bootstrap ]]; do
    sleep 1
done

LOG_FILE=$(mktemp)
mysqld --defaults-file=/etc/mysql/my.cnf --wsrep-recover --skip-networking --log-error=${LOG_FILE}
WSREP_POS=$(awk '/Recovered position:/ {print $(NF)}' ${LOG_FILE})
rm ${LOG_FILE}

ARGS=''
if [[ ${MARIADB_WSREP_NEW_CLUSTER} == 1 ]]; then
    if [[ -f /var/log/mysql/wsrep_new_cluster ]]; then
        echo "WARN: Please unset MARIADB_WSREP_NEW_CLUSTER flag; Continuing without flag"
    else
        ARGS+="--wsrep-new-cluster"
        touch /var/log/mysql/wsrep_new_cluster
    fi
else
    rm -f /var/log/mysql/wsrep_new_cluster
fi

mysqld --defaults-file=/etc/mysql/my.cnf --wsrep-start-position=${WSREP_POS} ${ARGS} &

wait
