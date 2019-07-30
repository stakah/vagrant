#!/bin/bash

sudo yum install openssh-server

echo "Starting sshd.service"
sudo systemctl start sshd.service

echo "Enabling sshd.service to start-up on boot"
sudo systemctl enable sshd.service