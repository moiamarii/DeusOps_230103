BOX_IMAGE = "ubuntu/focal64"
NODE_COUNT = 4

Vagrant.configure("2") do |config|
  config.vm.define "minio1" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "minio1"
    subconfig.vm.network "public_network"
    subconfig.vm.network "forwarded_port", guest: 9001, host: 9001
    subconfig.vm.network "forwarded_port", guest: 9002, host: 9000

    subconfig.vm.provision "docker" do |d|
    subconfig.vm.provision "shell", inline: <<-SHELL
       docker swarm init --advertise-addr enp0s8 | grep 2377 >> /vagrant/swarm_token.sh
       echo "access-key-12345" | docker secret create access_key -
       echo "secret-key-54321" | docker secret create secret_key -
    SHELL
  end
end

  (2..NODE_COUNT).each do |i|
    config.vm.define "minio#{i}" do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = "minio#{i}"
      subconfig.vm.network "public_network"

      subconfig.vm.provision "docker" do |d|
      subconfig.vm.provision "shell", inline: <<-SHELL
         sh /vagrant/swarm_token.sh
    SHELL
    end
  end
end
end
