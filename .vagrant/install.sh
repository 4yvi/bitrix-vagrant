#!/bin/bash

# Подключаем репозиторий IUS
cd /tmp
curl 'https://setup.ius.io/' -o setup-ius.sh
bash setup-ius.sh

# Устанавливаем Vim
yum install vim -y

# Устанавливаем nano
yum install nano -y

# Устанавливаем время
yum -y install tzdata -y
mv /etc/localtime /etc/localtime.bak
ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime
yum -y install ntp -y
systemctl start ntpd

# Удаляем все версии php-fpm php-cli php-common
yum remove php-fpm php-cli php-common -y

# Устанавливем PHP 7
yum install php70u-fpm-nginx php70u-cli php70u-mysqlnd -y

# Устаннавливаем права на папку /var/lib/nginx
chown -R vagrant:vagrant /var/lib/nginx

# Создаем папку tmp для php
mkdir /home/www/tmp

# Устанавливаем расширения для php
yum install gcc make -y
yum install php70u-pear php-devel -y

# Список расширений для установки (Можно добавить свои)
yum install php70u-bz2 -y
yum install php70u-calendar -y
yum install php70u-cgi-fcgi -y
yum install php70u-core -y
yum install php70u-ctype -y
yum install php70u-date -y
yum install php70u-exif -y
yum install php70u-fileinfo -y
yum install php70u-filter -y
yum install php70u-ftp -y
yum install php70u-gettext -y
yum install php70u-gmp -y
yum install php70u-hash -y
yum install php70u-iconv -y
yum install php70u-libxml -y
yum install php70u-openssl -y
yum install php70u-pcntl -y
yum install php70u-pcre -y
yum install php70u-phar -y
yum install php70u-readline -y
yum install php70u-reflection -y
yum install php70u-session -y
yum install php70u-shmop -y
yum install php70u-simplexml -y
yum install php70u-sockets -y
yum install php70u-spl -y
yum install php70u-sqlite3 -y
yum install php70u-standard -y
yum install php70u-tokenizer -y
yum install php70u-xml -y
yum install php70u-zlib -y
yum install php70u-curl -y
yum install php70u-dom -y
yum install php70u-gd -y
yum install php70u-json -y
yum install php70u-mbstring -y
yum install php70u-mcrypt -y
yum install php70u-mysqli -y
yum install php70u-mysqlnd -y
yum install php70u-opcache -y
yum install php70u-pdo -y
yum install php70u-pdo_mysql -y
yum install php70u-soap -y
yum install php70u-xmlrpc -y

# Рестарт
systemctl restart php-fpm
systemctl restart nginx

# Установка mySQL
yum install mariadb-server mariadb-client -y
systemctl start mariadb

# Установка Redis
#yum install redis -y

# Установка Memcached
#yum install memcached -y

#Создаем пользователя в mySQL
mysql -u root -e "CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant';"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'vagrant'@'localhost';"

# Создаем базу vagrant
mysql -u root -e "CREATE DATABASE vagrant"

# Копируем конфиги
\cp /home/www/.vagrant/www.conf /etc/php-fpm.d/
\cp /home/www/.vagrant/php-fpm.conf /etc/nginx/conf.d/
\cp /home/www/.vagrant/nginx.conf /etc/nginx/
\cp /home/www/.vagrant/php.ini /etc/
\cp /home/www/.vagrant/server.cnf /etc/my.cnf.d/

# Автозагрузка
systemctl enable php-fpm
systemctl enable nginx
systemctl enable mariadb.service
systemctl enable ntpd
