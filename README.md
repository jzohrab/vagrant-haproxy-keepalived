Vagrant-haproxy-keepalived
====================

Demo of HAProxy high availability using Vagrant

This is the toolset is forked from Vagrant-haproxy-demo.

# What does the Vagrantfile do?
* It sets up a 4 VM mini public network inside Virtualbox.  The three hosts are haproxy1 (192.168.1.9), haproxy1 (192.168.1.10), web1 (192.168.1.11), and web2 (192.168.1.12)
* It set a vip addres (192.168.1.2)
* It installs Apache on the two web servers, and configures it with a index page that identifies which host you're viewing the page on.
* It installs HAProxy and keepalived on the two haproxy hosts, and drops a configuration file in place with the two webservers pre-configured.

# Prerequisites
1.  Install [Vagrant](http://www.vagrantup.com/downloads.html)
2.  Install [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
3.  Either clone this repo with ``` git clone https://github.com/mezgani/vagrant-haproxy-keepalived.git ``` or just download the [current zip file](https://github.com/mezgani/vagrant-haproxy-keepalived/archive/master.zip) and extract it in an empty directory.

# Getting started
1.  Open 4 terminal windows -- one for each host.  Change to the directory containing the Vagrantfile from step 3 above.
2.  In terminal #1, run ``` vagrant up haproxy1 && vagrant ssh haproxy1 ```
3.  In terminal #2, run ``` vagrant up haproxy2 && vagrant ssh haproxy2 ```
4.  In terminal #3, run ``` vagrant up web1 && vagrant ssh web1 ```
5.  In terminal #4, run ``` vagrant up web2 && vagrant ssh web2 ```
6.  Open up [http://192.168.1.9/](http://192.168.1.9/) in your host's browser.  This is the haproxy1 load balanced 
7.  Open up [http://192.168.1.10/](http://192.168.1.10/) in your host's browser.  This is the haproxy2 load balanced 
8.  Open up [http://192.168.1.11/](http://172.28.33.11/) in a browser to see if web1's Apache is working.
9.  Open up [http://192.168.1.12/](http://172.28.33.12/) in a browser to see if web2's Apache is working.
10.  To shut down the VM's, run ``` vagrant halt web1 web2 haproxy1 haproxy2 ```
11.  To remove the VM's from your hard drive, run ``` vagrant destroy web1 web2 haproxy ```
12.  If you wish to remove the cached image file from which these machines were created, run ``` vagrant box remove precise32 ```

# Reference material
* [Vagrant](http://vagrantup.com)
* [VirtualBox](http://www.virtualbox.org)
* [HAProxy](http://haproxy.1wt.eu/)
* [Keepalived](http://www.keepalived.org/)

