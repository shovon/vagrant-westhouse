# West House Vagrant Box

A development environment for the West House Project. It solves the problem of "hey, it doesn't work on my machine!"

It does so by running a headless VirtualBox Ubuntu 12.04 64-bit Virtual Machine (VM). Databases like MongoDB will run in the context of the VM. More on how to access the database below (in the section on "Exposed Services").

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

### A Possible Error

If running the Vagrant set-up for the first time, you get:

```
npm ERR! Error: ENOENT, open '/root/.npm/d35370f3-websocket-1-0-8.lock'
npm ERR! If you need help, you may report this log at:
npm ERR!     <http://github.com/isaacs/npm/issues>
npm ERR! or email it to:
npm ERR!     <npm-@googlegroups.com>

npm ERR! System Linux 3.2.0-23-generic
npm ERR! command "/usr/local/bin/node" "/usr/local/bin/npm" "install"
npm ERR! cwd /home/vagrant/cube
npm ERR! node -v v0.10.22
npm ERR! npm -v 1.3.14
npm ERR! path /root/.npm/d35370f3-websocket-1-0-8.lock
npm ERR! code ENOENT
npm ERR! errno 34
```

Just run:

```shell
vagrant provision
```

And the issue should resolve itself.

## Exposed Services

- MongoDB: port 2701
- Cube's Collector TCP server: port 1080
- Cube's Collector UDP server: port 1180
- Cube's Evaluator: port 1081