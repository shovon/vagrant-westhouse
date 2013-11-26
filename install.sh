#!/usr/bin/env bash

# Get into root
sudo su

# Install MongoDB if necessary.
if [ ! -f /usr/bin/mongos ]; then

  # Add MongoDB to apt
  apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
  # Update the repo list
  apt-get -y update
  # Install latest stable version of mongo
  apt-get install -y mongodb-10gen

fi

# Get the build helper packages, such as G++, GCC, make, etc.
apt-get install build-essential -y
# Git is what will allow us to download source code that use the git VCS.
# Will be used later to install 
apt-get install git -y

# Install Node.js if necessary.
if [ ! -f /usr/local/bin/node ]; then

  # Download the Node.js repo.
  git clone https://github.com/joyent/node.git
  # Change the directory to the repo's folder.
  cd node
  # Check out the latest stable release.
  git checkout v0.10.22
  # Compile, and install Node.js
  ./configure && make && make install

  cd ..
  rm -rf node

fi

# Install Square's Cube if necessary
if [ ! -f /etc/init/cube-collector.conf ]; then

  # We will be saving cube in our home directory.
  cd /home/vagrant
  # Download the Cube repo.
  if [ ! -d cube ]; then
    git clone https://github.com/square/cube.git
    # Change the directory into the repo's folder.
    cd cube
    # Check out the latest stable release.
    git checkout v0.2.12
    # Install Cube's dependencies
    npm install

    cd ..
  fi

  COLLECTOR_FILE=$(cat <<EOF
#!upstart
description "A collector for the Cube DBMS"
author "Salehen Shovon Rahman"

start on startup
stop on shutdown

env PROGRAM_NAME="cube-collector"
env NODE_PATH="/usr/local/bin/node"
env COLLECTOR="/home/vagrant/cube/bin/collector.js"

script
  echo "Trying to start the collector..."
  echo \$\$ > /var/run/\$PROGRAM_NAME.pid
  exec \$NODE_PATH \$COLLECTOR >> /var/log/\$PROGRAM_NAME.sys.log 2>&1
end script
EOF)

  echo "$COLLECTOR_FILE" > /etc/init/cube-collector.conf
  
  start cube-collector

  EVALUATOR_FILE=$(cat <<EOF
#!upstart
description "The evaluator for the cube DBMS"
author "Salehen Shovon Rahman"

start on startup
stop on shutdown

env PROGRAM_NAME="cube-evaluator"
env NODE_PATH="/usr/local/bin/node"
env EVALUATOR="/home/vagrant/cube/bin/evaluator.js"

script
  echo \$\$ > /var/run/\$PROGRAM_NAME.pid
  exec \$NODE_PATH \$EVALUATOR >> /var/log/\$PROGRAM_NAME.sys.log 2>&1
end script
EOF)

  echo "$EVALUATOR_FILE" > /etc/init/cube-evaluator.conf

  start cube-evaluator

fi