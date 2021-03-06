#!/bin/bash

apt-get update
apt-get install -y curl git python

adduser --disabled-password --gecos "" vegalive

mkdir -p /opt/dropbox
mkdir -p /home/vegalive/Dropbox

cd /opt
git clone https://github.com/circolodelre/vegalive/
cd vegalive
ln -s /opt/dropbox ./.dropbox-dist
ln -s /home/vegalive/Dropbox ./tournaments
chmod +x dropbox.py
cp dropbox /etc/init.d/
chmod +x /etc/init.d/dropbox
echo DROPBOX_USERS=\"vegalive\" > /etc/default/dropbox
update-rc.d dropbox defaults

curl -Lo dropbox-linux-x86_64.tar.gz https://www.dropbox.com/download?plat=lnx.x86_64
tar xzfv dropbox-linux-x86_64.tar.gz --strip 1 -C /opt/dropbox

/opt/dropbox/dropboxd

service dropbox start
