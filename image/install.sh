#!/bin/bash
set -e
source /build/buildconfig
source /build/narra/buildconfig
set -x

# Prepare NARRA to update repo while boot
mkdir -p /etc/my_init.d
cp /build/narra/narra.sh /etc/my_init.d/narra.sh

if [[ "$master" = 1 ]]; then
	# Enable the Redis service
	rm -f /etc/service/redis/down;
	# Enable the Mongodb service.
	mkdir /etc/service/mongo;
	cp /build/narra/runit/mongodb.sh /etc/service/mongo/run;
	chown root /etc/service/mongo/run;
	# Nginx initialization
	rm -f /etc/service/nginx/down;
	rm /etc/nginx/sites-enabled/default;
	cp /build/narra/config/narra.conf /etc/nginx/sites-enabled/narra.conf;
fi

if [[ "$worker" = 1 ]]; then
	# Enable the NARRA worker service.
	mkdir /etc/service/narra-worker;
	cp /build/narra/runit/narra-worker.sh /etc/service/narra-worker/run;
	chown root /etc/service/narra-worker/run;
fi