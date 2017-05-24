#!/bin/bash

set -eux

chown rabbitmq:rabbitmq /var/{lib,log}/rabbitmq/

touch /var/log/rabbitmq/chown
