#!/usr/bin/env bash

# Get into root
sudo su

apt-get install build-essential -y

apt-get update -y

echo "mysql-server mysql-server/root_password select root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again select root" | debconf-set-selections

apt-get -y install mysql-server

mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"

restart mysql

echo "create database development;" | mysql -uroot -proot

cat /vagrant/configs/my.cnf > /etc/mysql/my.cnf

restart mysql

apt-get install redis-server -y

apt-get install git -y

apt-get install curl -y

mkdir /var/www

chown -R vagrant /var/www

su - vagrant

vagrant_home=/home/vagrant
git clone https://github.com/creationix/nvm.git $vagrant_home/.nvm

source $vagrant_home/.nvm/nvm.sh

nvm install v0.10.26
