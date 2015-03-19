# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "WebHost1(14.04)"
    config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

    config.ssh.forward_agent = true

    config.vm.network :forwarded_port, guest: 80,   host: 8181
    config.vm.network :forwarded_port, guest: 443,   host: 8383
    config.vm.network :forwarded_port, guest: 3306, host: 9191
    config.vm.network :forwarded_port, guest: 21, host: 2323
    config.vm.hostname = "#DOMAIN"

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
    end

    config.vm.provision "shell", path: "provision/bootstrap.sh"

end
