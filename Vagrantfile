Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.hostname = "php7devbox"
	config.vm.provision "shell", path: "vagrantconfigfiles/provision.sh"
	config.vm.network "forwarded_port", guest: 80, host:1234, id: "nginx"
end
