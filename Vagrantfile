# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 256]
  end

  config.vm.define :haproxy1, primary: true do |haproxy1_config|

    haproxy1_config.vm.hostname = 'haproxy1'  
    haproxy1_config.vm.network :public_network, ip: "192.168.1.9"
    haproxy1_config.vm.provision :shell, :path => "haproxy1-setup.sh"

  end
   config.vm.define :haproxy2, primary: true do |haproxy2_config|

    haproxy2_config.vm.hostname = 'haproxy2'
    haproxy2_config.vm.network :public_network, ip: "192.168.1.10"
    haproxy2_config.vm.provision :shell, :path => "haproxy2-setup.sh"

  end
  config.vm.define :web1 do |web1_config|

    web1_config.vm.hostname = 'web1'
    web1_config.vm.network :public_network, ip: "192.168.1.11"
    web1_config.vm.provision :shell, :path => "web-setup.sh"


  end
  config.vm.define :web2 do |web2_config|

    web2_config.vm.hostname = 'web2'
    web2_config.vm.network :public_network, ip: "192.168.1.12"
    web2_config.vm.provision :shell, :path => "web-setup.sh"

  end
end
