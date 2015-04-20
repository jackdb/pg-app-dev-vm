# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: $script

  config.vm.provider "virtualbox" do |v|
	  v.memory = 2048 #postgis might need more than this
	  v.cpus = 1
	end

end

Vagrant::Config.run do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.share_folder "bootstrap", "/mnt/bootstrap", ".", :create => true
  config.vm.provision :shell, :path => "Vagrant-setup/bootstrap.sh"
  config.vm.provision :shell, :path => "Vagrant-setup/compile_gdal.sh"
 
  # PostgreSQL Server port forwarding
  config.vm.forward_port 5432, 25432
end
