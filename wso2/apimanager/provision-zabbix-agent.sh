#!/bin/bash

# Provision zabbix agent

wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb
sudo dpkg -i zabbix-release_3.0-1+trusty_all.deb
sudo apt-get update
sudo apt-get install zabbix-agent

cp -f /vagrant/zabbix_agentd.conf /usr/local/etc/
