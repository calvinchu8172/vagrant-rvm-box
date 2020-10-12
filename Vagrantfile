# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty64'

  config.vm.synced_folder './work', '/vagrant'
  config.vm.synced_folder '~/Docker', '/docker'

  config.vm.network "private_network", ip: "192.168.50.10"
  # config.vm.network :forwarded_port, guest: 8080, host: 8080
  # config.vm.network :forwarded_port, guest: 443, host:443
  # config.vm.network :forwarded_port, guest: 9324, host:9324
  config.vm.network :forwarded_port, guest: 3000, host: 3001
  # config.vm.network :forwarded_port, guest: 3306, host: 3306
  config.vm.network "forwarded_port", guest: 5222, host: 5222
  config.vm.network "forwarded_port", guest: 5223, host: 5223
  config.vm.network "forwarded_port", guest: 5269, host: 5269
  config.vm.network "forwarded_port", guest: 5280, host: 5280
  config.vm.network "forwarded_port", guest: 6379, host: 6379
  config.vm.network "forwarded_port", guest: 8888, host: 8888

  config.vbguest.auto_update = true


  config.vm.provision :shell, path: "bootstrap.sh", keep_color: true

  config.vm.provider "virtualbox" do |v|
   v.memory = 4096
   v.cpus = 2
  end
end
