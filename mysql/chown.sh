#!/bin/bash

set -eux

chown mysql:mysql /var/{lib,log}/mysql/

touch /var/log/mysql/chown
