#!/usr/bin/env bash

# Get into root
sudo su

apt-get update -y

echo "mysql-server mysql-server/root_password select root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again select root" | debconf-set-selections

apt-get -y install mysql-server

mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"

restart mysql

cat /dev/null > /etc/mysql/my.cnf
cat /vagrant/configs/my.cnf > /etc/mysql/my.cnf

restart mysql

sudo apt-get install redis-server