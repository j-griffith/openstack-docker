#!/bin/bash

set -eux

chown ${PROJECT}:${PROJECT} /var/{lib,log}/${PROJECT}/

touch /var/log/${PROJECT}/chown
