# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"  #Box Name
  config.vm.box_url = "http://files.vagrantup.com/precise64.box" #Box Location
  
  config.vm.provider :virtualbox do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--memory", "2048"]
  end
  
  config.vm.synced_folder "../", "/home/vagrant/synced/", :nfs => true
  #config.vm.network :forwarded_port, guest: 80, host: 8080 # Forward 8080 rquest to vagrant 80 port
  config.vm.network :private_network, ip: "10.10.47.11"

  config.vm.provision "shell" do |s|
    s.path = "vagrant.sh"
    s.args   = "'/home/vagrant/synced'"
  end

end