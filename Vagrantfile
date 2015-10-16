# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Vagrant file for local testing of created boxes
#
Vagrant.configure(2) do |config|
  required_plugins = %w( vagrant-hostsupdater )

  required_plugins.each do |plugin|
    system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
  end

  config.vm.define "win2012R2" do |win2012R2|
    win2012R2.vm.box = "vagrant-windows2012R2"
    win2012R2.vm.box_url = "./box/vagrant-windows2012R2.box"
    win2012R2.vm.network :private_network, ip: "192.168.200.100"
    win2012R2.vm.hostname = "Win2012R2"
    win2012R2.hostsupdater.aliases = ["win2012R2"]
    win2012R2.vm.provider "virtualbox" do |v|
      v.name = "Win2012R2"
      v.gui = false
    end
    win2012R2.winrm.username = "vagrant"
    win2012R2.winrm.password = "vagrant"
  end

  config.vm.define "win2012R2core" do |win2012R2core|
    win2012R2core.vm.box = "vagrant-windows2012R2Core"
    win2012R2core.vm.box_url = "./box/vagrant-windows2012R2Core.box"
    win2012R2core.vm.network :private_network, ip: "192.168.200.150"
    win2012R2core.vm.hostname = "Win2012R2Core"
    win2012R2core.hostsupdater.aliases = ["win2012R2Core"]
    win2012R2core.vm.provider "virtualbox" do |v|
      v.name = "Win2012R2Core"
      v.gui = false
    end
    win2012R2core.winrm.username = "vagrant"
    win2012R2core.winrm.password = "vagrant"
  end
end
