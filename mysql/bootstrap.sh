#!/bin/bash

set -eux

function bootstrap {
    mysql_install_db

    mysqld --defaults-file=/etc/mysql/my.cnf --wsrep_on=OFF --skip-networking --socket=/tmp/mysqld.sock &

    while [[ ! -S /tmp/mysqld.sock ]]; do
        sleep 1
    done

    mysql --defaults-file=/etc/mysql/my.cnf --protocol=socket -uroot -hlocalhost --socket=/tmp/mysqld.sock <<EOF
SET @@SESSION.SQL_LOG_BIN=0;
INSTALL PLUGIN unix_socket SONAME 'auth_socket';
TRUNCATE mysql.user;
GRANT SHUTDOWN ON *.* TO 'mysql'@'localhost' IDENTIFIED VIA unix_socket;
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED VIA unix_socket WITH GRANT OPTION;
GRANT ALL ON *.* TO '${MARIADB_USER_WSREP_NAME}'@'%' IDENTIFIED BY '${MARIADB_USER_WSREP_PASS}';
GRANT ALL ON *.* TO '${MARIADB_USER_NAME}'@'%' IDENTIFIED BY '${MARIADB_USER_PASS}' ;
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

    mysqladmin -umysql --protocol=socket --socket=/tmp/mysqld.sock shutdown

    wait
}

while [[ ! -f /var/log/mysql/chown ]]; do
    sleep 1
done

if [[ ${MARIADB_BOOTSTRAP} == 1 ]]; then
    bootstrap
fi

touch /var/log/mysql/bootstrap

