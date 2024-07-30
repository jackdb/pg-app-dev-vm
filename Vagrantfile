# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "postgresql"

  config.vm.synced_folder ".", "/mnt/bootstrap", create: true
  
  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", path: "Vagrant-setup/bootstrap.sh"

  # PostgreSQL Server port forwarding
  config.vm.network "forwarded_port", guest: 5432, host: 15432, host_ip: "127.0.0.1"
end
