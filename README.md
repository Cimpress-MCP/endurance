#Endurance

This repo is meant to be a very simple way to build out windows boxes for the
[VirtualBox](https://www.virtualbox.org/wiki/Downloads) provider with [Packer](https://packer.io)
for use with [Vagrant](http://vagrantup.com).

## Pre-requisites

### Assumed installed and on path

* [Vagrant](http://vagrantup.com)
* [Packer](http://packer.io)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Ruby](https://www.ruby-lang.org/en/documentation/installation/)

### Repo specific pre-requisites

* Clone this repo locally
* Gather up your windows ISOs ( Windows7, Windows2008 and Windows2012R2 ) and place them in the corresponding ISOs folder
  * [Microsoft Evaluation Center](https://www.microsoft.com/en-us/evalcenter/)
  * [MSDN](https://msdn.microsoft.com/en-us/default.aspx)
  * Any local sources

## Quick start

Once you have cleared the above pre-requisites run the following at the root of this repo.

```
> gem install bundler
> bundle
> Rake build
```

Once the above has finished you should see three vagrant boxes in the box directory.
* vagrant-windows7.box
* vagrant-windows2008.box
* vagrant-windows2012R2.box
* vagrant-windows2012R2Core.box

## Vagrant box details

The boxes in this repo are specifically built to use [Chocolatey](https://chocolatey.org/) and winrm
with vagrant out of the box without having to install cygwin or similar packages on the guest os.

Each of the boxes have been worked through to bring them down to a more manageable size. Details of
what this entails can be seen in the ```bootstrap.ps1``` script in this repo.

### Default Vagrantfile

The Vagrantfile packed with each box is shown below.

```
Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--vram","30"]
    v.memory = 2048
    v.cpus = 1
  end
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
end
```
This will default every box to using the winrm communicator as well as forward the ports for winrm as
well as the ```vagrant rdp``` command.

### Default Specs

Each of the boxes are initially built via Packer with the following settings.

```
v.customize ["modifyvm", :id, "--vram","30"]
v.memory = 4096
v.cpus = 2
```

As shown in the default Vagrantfile above however these specs are cut back to the following.

```
v.customize ["modifyvm", :id, "--vram","30"]
v.memory = 2048
v.cpus = 1
```

### License Keys

All of the included ```Autounattend.xml``` files have no windows activation key set. This can be set
in the following location in each ```Autounattend.xml```

```
<ProductKey>
    <!-- Input Key Here-->
    <Key>PLACEKEYHERE</Key>
    <WillShowUI>Never</WillShowUI>
</ProductKey>
```

## Other Information

### Testing

This repo has been tested using the following setup.

####Windows 8.1:
* [Vagrant](http://vagrantup.com) - **1.7.4**
* [Packer](http://packer.io) - **0.8.2**
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - **5.0.0**
* [Ruby](https://www.ruby-lang.org/en/documentation/installation/) - **1.9.3**

####OSX 10.10.3
* [Vagrant](http://vagrantup.com) - **1.7.4**
* [Packer](http://packer.io) - **0.8.2**
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - **5.0.0**
* [Ruby](https://www.ruby-lang.org/en/documentation/installation/) - **1.9.3**

### ServerSpec

Currently the ServerSpec checks are looking for three basic items.

* Vagrant is a user that is in Administrators.
* Powershell ExecutionPolicy is set to Bypass.
* Chocolatey has installed correctly.

### Special thanks

The following two links were very helpful resources in building out this repo

* [packer-windows](https://github.com/joefitzgerald/packer-windows)
* [hurryupandwait.io](http://www.hurryupandwait.io/blog/in-search-of-a-light-weight-windows-vagrant-box)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
