# First time environment setup

## Start downloading the box

    brew install aria2
    aria2c -x4 "https://vagrantcloud.com/ubuntu/boxes/xenial64/versions/20191015.0.0/providers/virtualbox.box"

## Install VirtualBox

https://www.virtualbox.org/wiki/Downloads

## Install Vagrant

https://www.vagrantup.com/downloads.html

## Add the vagrant box

    vagrant box add ubuntu/xenial64 xenial-server-cloudimg-amd64-vagrant.box
    vagrant up