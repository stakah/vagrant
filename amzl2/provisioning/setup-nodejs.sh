#!/bin/bash

# echo "Installing NVM"
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# echo "Activating NVM"
# source ~/.nvm/nvm.sh

# echo "Installing nodejs 12.7.0"
# nvm install 12.7.0 --latest-npm --no-progress


###############################################################
# For ionic to work, nodejs must be installed as global package
###############################################################

curl --silent --location https://rpm.nodesource.com/setup_12.x | sudo bash -

sudo yum -y install nodejs

echo "Verifying installed version"
node -e "console.log('Running Node.js ' + process.version)"
