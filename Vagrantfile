# -*- mode: ruby -*-
# vi: set ft=ruby :

def local_cache(box_name)
  cache_dir = File.join(File.expand_path(File.dirname(__FILE__)), '.vagrant', 'cache', 'apt', box_name)
  partial_dir = File.join(cache_dir, 'partial')
  FileUtils.mkdir_p(partial_dir) unless File.exists? partial_dir
  cache_dir
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  cache_dir = local_cache(config.vm.box)
  config.vm.synced_folder cache_dir, "/var/cache/apt/archives/"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "KaiOS_Dev"
    vb.cpus = 4
    vb.gui = true
    vb.memory = "4096"
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']

    # See https://stackoverflow.com/questions/38956127/usb-device-is-not-visible-inside-vagrant/39014465#39014465
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "on"]
    vb.customize ["usbfilter", "add", "0", "--target", :id, "--name", "Nokia 8110 4G", '--vendorid', '0x05c6', '--productid', '0x9091']
  end

  config.vm.provision "shell", path: "provision.sh"
end
