#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install MongoDB.
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
apt-get update && \
apt-get install -y mongodb-org && \
rm -rf /var/lib/apt/lists/* &&\
mkdir -p /data/db && \
chown -R mongodb:mongodb /data
awk '/bind_ip/{print "bind_ip = 0.0.0.0";next}1' /etc/mongod.conf > /tmp/mongod.conf
cat /tmp/mongod.conf > /etc/mongod.conf 