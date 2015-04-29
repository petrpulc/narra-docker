#!/bin/bash
# Narra initialization
rm -rf /home/app/narra
mkdir /home/app/narra
git clone https://github.com/petrpulc/narra.git /home/app/narra
find /home/app/narra/config/mongoid.yml -type f -exec sed -i "s/localhost/$MONGO_PORT_27017_TCP_ADDR/g" {} \;
find /home/app/narra/config/redis.yml -type f -exec sed -i "s/localhost/$REDIS_PORT_6379_TCP_ADDR/g" {} \;
chown -R app:app /home/app/narra
cd /home/app/narra
sudo -u app bundle install --deployment
