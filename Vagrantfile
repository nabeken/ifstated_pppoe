# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_plugin "vagrant-guests-openbsd"

Vagrant.configure("2") do |config|
  config.vm.box = "vagrant-openbsd-53"
  config.vm.box_url = "http://projects.tsuntsun.net/~nabeken/boxes/vagrant-openbsd-53.box"
  config.vm.guest = :openbsd_v2

  """
                +--------------+
                | PPPoE Server |
                +--------------+
                     [em0]


            [em0]              [em0]
          +-----+              +-----+
          | gw0 |              | gw1 |
          +-----+              +-----+
            [em1]              [em1]
                    [carp0]


                     [em0]
                   +--------+
                   | server |
                   +--------+
  """

  config.vm.define :pppoe do |pppoe|
    pppoe.vm.box = "vagrant-openbsd-53c"
    pppoe.vm.box_url = "http://projects.tsuntsun.net/~nabeken/boxes/vagrant-openbsd-53c.box"
    pppoe.vm.network :private_network, ip: "192.168.50.254"
    pppoe.vm.hostname = "pppoe.example.org"
    pppoe.vm.provision :chef_solo do |chef|
      chef.nfs = true
      chef.cookbooks_path = %w{vendor/cookbooks ./cookbooks}
      chef.add_recipe "ifstated_pppoe"
      chef.add_recipe "ifstated_pppoe::pppoe"
    end
  end

  config.vm.define :gw0 do |gw0|
    gw0.vm.hostname = "gw0.example.org"
    gw0.vm.provision :chef_solo do |chef|
      chef.nfs = true
      chef.cookbooks_path = %w{vendor/cookbooks ./cookbooks}
      chef.add_recipe "ifstated_pppoe"
      chef.add_recipe "ifstated_pppoe::gw0"
    end
    gw0.vm.provider :virtualbox do |vb|
      (1..3).each do |i|
        vb.customize ['modifyvm', :id, "--nicpromisc#{i}", "allow-vms"]
      end
    end
    gw0.vm.network :private_network, ip: "192.168.50.2"
    gw0.vm.network :private_network, ip: "192.168.60.2"
  end

  config.vm.define :gw1 do |gw1|
    gw1.vm.provision :chef_solo do |chef|
      chef.nfs = true
      chef.cookbooks_path = %w{vendor/cookbooks ./cookbooks}
      chef.add_recipe "ifstated_pppoe"
      chef.add_recipe "ifstated_pppoe::gw1"
    end
    gw1.vm.hostname = "gw1.example.org"
    gw1.vm.provider :virtualbox do |vb|
      (1..3).each do |i|
        vb.customize ['modifyvm', :id, "--nicpromisc#{i}", "allow-vms"]
      end
    end
    gw1.vm.network :private_network, ip: "192.168.50.3"
    gw1.vm.network :private_network, ip: "192.168.60.3"
  end

  config.vm.define :server do |server|
    server.vm.network :private_network, ip: "192.168.60.20"
  end
end
