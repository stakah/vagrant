#!/bin/bash

# provision-new4j.sh

echo ${0}

# adding neo4j repository
wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list
sudo apt-get update -y

# installing the latest neo4j community edition
#sudo apt-get install neo4j

# installing the latest neo4j enterprise edition
sudo apt-get install neo4j-enterprise -y

