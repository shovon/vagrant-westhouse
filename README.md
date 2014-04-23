# West House Vagrant Box

A development environment for the West House Project. It solves the problem of "hey, it doesn't work on my machine!"

It does so by running a headless VirtualBox Ubuntu 12.04 64-bit Virtual Machine (VM). DBMSes--such as MySQL--will run in the context of the VM. More on how to access the database below (in the section on "Exposed Services").

## Set-Up

Be sure that you have the following installed

1. [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/)
3. vbguest plugin for vagrant. It's simply installed by running `vagrant plugin install vagrant-vbguest`

If you haven't done so already, download this Vagrant project:

```
git clone https://github.com/westhouseproject/vagrant-westhouse.git
```

Then, it's only a matter `cd`ing into `vagrant-westhouse` and then running `vagrant up`.

If it's your first time running this Vagrant set-up, then you might have to wait a few minutes for everything to install first. Otherwise, it should take a few seconds until the machine is fully booted.

You might get the following error right after running `vagrant up`:

```
Failed to mount folders in Linux guest. This is usually because
the "vboxsf" file system is not available. Please verify that
the guest additions are properly installed in the guest and
can work properly. The command attempted was:

mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` /vagrant /vagrant
mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` /vagrant /vagrant
```

To fix it, simply run:

```
vagrant up; vagrant ssh -c 'sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions'; vagrant reload
```

## Exposed Services

The VM instance is broadcasting on host 33.33.33.10.

- MySQL: port 3306, username: root, password: root
- Redis: port 6379
- InfuxDB: port 8083, port 8086