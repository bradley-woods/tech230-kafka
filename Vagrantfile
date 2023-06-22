Vagrant.configure("2") do |config|

  config.vm.define "kafka" do |kafka|

    # configure the VM settings
    kafka.vm.box = "ubuntu/focal64"
    # kafka.vm.network "private_network", ip:"192.168.10.100"
    kafka.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 2
    end

    # provision the VM to have Kafka server
    kafka.vm.provision "shell", path: "provision-kafka.sh", privileged: false
  end
end