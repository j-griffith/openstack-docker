#!/bin/bash

docker run -d -t --restart=always --entrypoint /etc/mysql/mysqld.sh -v /var/log/mysql/:/var/log/mysql/ -v /etc/mysql/:/etc/mysql/ -v mariadb:/var/lib/mysql/ -p ${NODE_IP}:3306:3306 -p${NODE_IP}:4444:4444 -p ${NODE_IP}:4567:4567/udp -p ${NODE_IP}:4567-4568:4567-4568 --name mariadb mariadb:10.1

docker run --restart=always -d --name keystone -t -p ${NODE_IP}:5000:5000 -v /etc/keystone/:/etc/keystone/ samyaple/loci-keystone:newton /etc/keystone/start.sh
docker run --restart=always -d --name glance-registry -t -p ${NODE_IP}:9191:9191 -v /etc/glance/:/etc/glance/ -v /var/log/glance/:/var/log/glance/ -v /etc/ceph/:/etc/ceph/ samyaple/loci-glance:newton-ceph /etc/glance/glance-registry.sh
docker run --restart=always -d --name glance-api -t -p ${NODE_IP}:9292:9292 -v /etc/glance/:/etc/glance/ -v /var/log/glance/:/var/log/glance/ -v /etc/ceph/:/etc/ceph/ samyaple/loci-glance:newton-ceph /etc/glance/glance-api.sh
docker run --restart=always -d --name cinder-api -t -p ${NODE_IP}:8776:8776 -v /etc/cinder/:/etc/cinder/ -v /var/log/cinder/:/var/log/cinder/ -v /etc/ceph/:/etc/ceph/ samyaple/loci-cinder:newton-ceph /etc/cinder/cinder-api.sh

docker run --name=ovsdb-server --restart=always -d -t -p 127.0.0.1:6640:6640 -v /etc/openvswitch/:/etc/openvswitch/ -v /run/openvswitch/:/run/openvswitch/ samyaple/openvswitch /etc/openvswitch/ovsdb-server.sh
docker run --name=ovs-vswitchd --restart=always -d -t --net=host --userns=host --cap-add NET_ADMIN -v /etc/openvswitch/:/etc/openvswitch/ -v /run/openvswitch/:/run/openvswitch/ samyaple/openvswitch:temp /etc/openvswitch/ovs-vswitchd.sh

