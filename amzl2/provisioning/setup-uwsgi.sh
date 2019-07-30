#!/bin/bash

sudo yum groupinstall "Development Tools"
sudo yum update -y  
sudo yum install python3 -y
sudo yum install python-devel -y

# source ~/venv/python3/bin/activate

which python3

curl http://uwsgi.it/install | bash -s default /tmp/uwsgi
sudo cp /tmp/uwsgi /usr/bin/
