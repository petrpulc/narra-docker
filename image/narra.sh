#!/bin/bash
# Narra initialization
rm -rf /home/app/narra
mkdir /home/app/narra
git clone https://github.com/CAS-FAMU/narra.git /home/app/narra
chown -R app:app /home/app/narra
cd /home/app/narra
sudo -u app bundle install --deployment