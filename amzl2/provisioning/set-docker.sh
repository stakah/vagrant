#!/bin/bash

sudo amazon-linux-extras install docker

echo "Enabling docker daemon to start-up on boot"
sudo systemctl enable docker.service

echo "Adding $USER to docker group"
sudo usermod -a -G docker $USER