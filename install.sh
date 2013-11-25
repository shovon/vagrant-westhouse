#!/usr/bin/env bash

# Get into root
sudo su

# Checks to see whether or not MongoDB is installed.
if [ ! -f /usr/bin/mongos ]; then

    # Add mongo to apt
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

    # Update the repo list
    apt-get -y update

    # Install latest stable version of mongo
    apt-get install -y mongodb-10gen

fi