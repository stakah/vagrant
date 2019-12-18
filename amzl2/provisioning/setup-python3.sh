#!/bin/bash

echo "Updating yum repository base"
sudo yum update

echo "Installed python version"
python --version

echo "Installing Development Tools"
sudo yum groupinstall "Development Tools"

echo "Installing python3"
sudo yum install python3 -y

echo "Confirming that python3 was succesfuly installed"
which python3

echo "Installing latest pip and setuptools"
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

echo "Verifying installed pip version"
pip --version

echo "Installing python-devel"
# sudo yum install python-devel -y
sudo yum install python3-devel -y

echo "Installing virtualenv"
pip install --user virtualenv

echo "Current directory"
pwd

echo "Creating virtualenv directory"
mkdir venv

cd venv
pwd

echo "Creating virtual environment for python3"
virtualenv -p /usr/bin/python3 python3

echo "Activating the virtual environment"
source /home/vagrant/venv/python3/bin/activate

echo "Adding virtualenv activate to ~/.bashrc"
if [ ! -f "/home/vagrant/.bashrc.bak" ]; then
    sudo cp /home/vagrant/.bashrc /home/vagrant/.bashrc.bak
else
    sudo cp -f /home/vagrant/.bashrc.bak /home/vagrant/.bashrc
fi
echo "source /home/vagrant/venv/python3/bin/activate" >> /home/vagrant/.bashrc

echo "Confirming that python3 is being execute inside virtual environment"
which python

echo "Installing AWS boto3"
pip install boto3

