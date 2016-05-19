#!/bin/bash

apt-get update -y

dpkg -s nginx &>/dev/null ||
{
	apt-get -y install nginx
}

dpkg -s tmux &>/dev/null ||
{
	apt-get -y install tmux
}

dpkg -s curl &>/dev/null ||
{
	apt-get install curl
}

dpkg -s wget &>/dev/null ||
{
	apt-get install wget
}
command -v php &>/dev/null ||
{
	sudo apt-get install python-software-properties
	sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
	apt-get update -y
	apt-get install php7.0 php7.0-fpm  php7.0-cli php7.0-curl php7.0-gd  php7.0-mysql php7.0-intl -y
	apt-get install php7.0-dev -y
	apt-get install php-memcached -y
	apt-get --purge autoremove -y
}

command -v composer &>/dev/null ||
{
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '92102166af5abdb03f49ce52a40591073a7b859a86e8ff13338cf7db58a19f7844fbc0bb79b2773bf30791e935dbd938') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
	mv composer.phar /usr/local/bin/composer
}

service nginx start

if [ -d "/etc/nginx/sites-enabled" ]
	then
		rm -rf /etc/nginx/sites-enabled
		cp -r /vagrant/vagrant-config-files/nginx/sites-enabled /etc/nginx
fi

service nginx restart;
