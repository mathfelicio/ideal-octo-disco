#!/bin/bash

apt-get -y update

command -v php &>/dev/null ||
{
	sudo apt-get install python-software-properties
	sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
	apt-get -y update
	apt-get install php7.0 php7.0-fpm php7.0-mysql -y
	apt-get --purge autoremove -y
}


command -v composer &>/dev/null ||
{
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '92102166af5abdb03f49ce52a40591073a7b859a86e8ff13338cf7db58a19f7844fbc0bb79b2773bf30791e935dbd938') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
}

dpkg -s nginx &>/dev/null ||
{
	apt-get -y install nginx
}

service nginx start 
