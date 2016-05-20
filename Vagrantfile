Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.hostname = "php7devbox"
	config.vm.provision "shell", path: "vagrant-config-files/provision.sh"
	config.vm.network "forwarded_port", guest: 80, host:1234, id: "nginx"
	config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
end
