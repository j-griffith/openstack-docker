#!/bin/bash

set -eux

trap 'su -c "mysqladmin -umysql shutdown" mysql' SIGINT SIGTERM SIGHUP

mysqld --defaults-file=/etc/mysql/my.cnf --user=root --wsrep-recover --skip-networking --log-error=/tmp/wsrep-recover.log
WSREP_POS=$(awk '/Recovered position:/ {print $(NF)}' /tmp/wsrep-recover.log)
rm /tmp/wsrep-recover.log

mysqld --defaults-file=/etc/mysql/my.cnf --user=root --wsrep-start-position=${WSREP_POS} &

wait
