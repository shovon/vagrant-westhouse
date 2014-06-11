#!/usr/bin/env bash

# Get into root.

sudo su

apt-get update -y

# Install build-essential.

apt-get install build-essential -y

# Install MySQL

echo "mysql-server mysql-server/root_password select root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again select root" | debconf-set-selections

apt-get -y install mysql-server

mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"

restart mysql

echo "create database development;" | mysql -uroot -proot

cat /vagrant/configs/my.cnf > /etc/mysql/my.cnf

restart mysql

# Install Redis

cd /tmp
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make

cp src/redis-server /usr/local/bin
cp src/redis-cli /usr/local/bin
cp /vagrant/configs/redis-server.conf /etc/init/redis-server.conf
mkdir /home/vagrant/redis-saves
start redis-server

# Install Git

apt-get install git -y

# Install cURL

apt-get install curl -y

# Get out of root.

su - vagrant

vagrant_home=/home/vagrant

# Install Node.js

git clone https://github.com/creationix/nvm.git $vagrant_home/.nvm

source $vagrant_home/.nvm/nvm.sh

nvm install v0.10
