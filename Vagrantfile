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

  config.vm.define "win7" do |win7|
    win7.vm.box = "vagrant-windows7"
    win7.vm.box_url = "./box/vagrant-windows7.box"
    win7.vm.network :private_network, ip: "192.168.200.200"
    win7.vm.provision "shell",
      run: "always",
      inline: "netsh advfirewall firewall set rule name=\"Windows Remote Management (HTTP-In)\" profile=private dir=in new profile=\"private,public\""
    win7.vm.hostname = "Win7"
    win7.hostsupdater.aliases = ["win7"]
    win7.vm.provider "virtualbox" do |v|
      v.name = "Win"
      v.gui = true
    end
    win7.winrm.username = "vagrant"
    win7.winrm.password = "vagrant"
  end

  config.vm.define "win2008" do |win2008|
    win2008.vm.box = "vagrant-windows2008"
    win2008.vm.box_url = "./box/vagrant-windows2008.box"
    win2008.vm.network :private_network, ip: "192.168.200.50"
    win2008.vm.hostname = "Win2008"
    win2008.hostsupdater.aliases = ["win2008"]
    win2008.vm.provider "virtualbox" do |v|
      v.name = "Win2008"
      v.gui = true
    end
    win2008.winrm.username = "vagrant"
    win2008.winrm.password = "vagrant"
  end

  config.vm.define "win2012R2" do |win2012R2|
    win2012R2.vm.box = "vagrant-windows2012R2"
    win2012R2.vm.box_url = "./box/vagrant-windows2012R2.box"
    win2012R2.vm.network :private_network, ip: "192.168.200.100"
    win2012R2.vm.hostname = "Win2012R2"
    win2012R2.hostsupdater.aliases = ["win2012R2"]
    win2012R2.vm.provider "virtualbox" do |v|
      v.name = "Win2012R2"
      v.gui = true
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
      v.gui = true
    end
    win2012R2core.winrm.username = "vagrant"
    win2012R2core.winrm.password = "vagrant"
  end
end
