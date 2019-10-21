# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  # config.vm.network "forwarded_port", guest: 6000, host: 6000, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "KaiOS_Dev"
    vb.cpus = 4
    vb.gui = true
    vb.memory = "4096"
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
  end

  config.vm.provision "shell", path: "provision.sh"
end
