# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "docker" do |d|
  end

  config.vm.provision "docker" do |d|
    d.pull_images "tutum/mysql"
    d.run "tutum/mysql", args: ' -e MYSQL_PASS="password" --name mysql -p 3306:3306'
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y mysql-client
  SHELL
end
