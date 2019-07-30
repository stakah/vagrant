#!/bin/bash

echo "Installing nginx 1.12"
sudo amazon-linux-extras install nginx1.12

echo "Enabling nginx daemon"
sudo systemctl enable nginx.service

echo "Starting nginx service"
sudo systemctl start nginx.service

echo "Nginx daemon status"
sudo systemctl status -l nginx.service
