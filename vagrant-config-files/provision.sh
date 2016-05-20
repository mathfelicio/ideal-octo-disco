#!/bin/bash

apt-get update -y

dpkg -s nginx &>/dev/null ||
{
	apt-get install nginx -y
}

dpkg -s tmux &>/dev/null ||
{
	apt-get install tmux -y
}

dpkg -s curl &>/dev/null ||
{
	apt-get install curl -y
}

dpkg -s wget &>/dev/null ||
{
	apt-get install wget -y
}
command -v php &>/dev/null ||
{
	apt-get autoremove --purge php5-*
	add-apt-repository ppa:ondrej/php
	apt-get update -y
	apt-get install php7.0-fpm php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-mysql php7.0-phpdbg php7.0-mbstring php7.0-gd php7.0-imap php7.0-ldap php7.0-pgsql php7.0-pspell php7.0-recode php7.0-snmp php7.0-tidy php7.0-dev php7.0-intl php7.0-gd php7.0-curl php7.0-zip php7.0-xml -y
	apt-get install php-redis -y
	apt-get install php-xdebug -y
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

service php7.0-fpm restart
service nginx restart


