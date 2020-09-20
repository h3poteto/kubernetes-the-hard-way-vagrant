# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "archlinux/archlinux"

  config.vm.boot_timeout = 600  
  
  config.vm.define "master" do |c|
    c.vm.hostname = "master"

    c.vm.network "private_network", ip: "10.240.0.10"
    c.vm.network "forwarded_port", guest: 6443, host: 6443
  end

  config.vm.define "node-0" do |c|
    c.vm.hostname = "node-0"

    c.vm.network "private_network", ip: "10.240.0.20"
    c.vm.network "public_network"
  end

  config.vm.define "node-1" do |c|
    c.vm.hostname = "node-1"

    c.vm.network "private_network", ip: "10.240.0.21"
    c.vm.network "public_network"
  end
  
  

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./scripts", "/provisoning_scripts"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = "1024"
    vb.cpus = 1
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
pacman-key --populate archlinux
pacman -Sy --noconfirm
pacman -S docker --noconfirm
pacman -S git base-devel wget --noconfirm
pacman -S ebtables ethtool socat conntrack-tools ipset net-tools --noconfirm 
systemctl enable docker
systemctl start docker
usermod -aG docker vagrant
swapoff -a
cat /etc/fstab
sudo sed -ri '/\\sswap\\s/s/^#?/#/' /etc/fstab
cat /etc/fstab

cat >/etc/hosts <<EOF
127.0.0.1       localhost

# KTHW Vagrant machines
10.240.0.10     master
10.240.0.20     node-0
10.240.0.21     node-1
EOF
  SHELL
end
