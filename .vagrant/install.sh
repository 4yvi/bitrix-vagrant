#!/bin/bash

# Подключаем репозиторий IUS
cd /tmp
curl 'https://setup.ius.io/' -o setup-ius.sh
bash setup-ius.sh

# Устанавливаем Vim
yum install vim

# Устанавливаем nano
yum install nano -y

# Удаляем все версии php-fpm php-cli php-common
yum remove php-fpm php-cli php-common -y

# Устанавливем PHP 7
yum install php70u-fpm-nginx php70u-cli php70u-mysqlnd -y

# Настраиваем PHP 7 для работы с Nginx
\cp /home/www/.vagrant/www.conf /etc/php-fpm.d/
\cp /home/www/.vagrant/php-fpm.conf /etc/nginx/conf.d/
\cp /home/www/.vagrant/nginx.conf /etc/nginx/

# Устанавливаем расширения для php
yum install gcc make -y
yum install php-pear php-devel -y

# Список расширений для установки (Можно добавить свои)
yum install php-bz2 -y
yum install php-calendar -y
yum install php-cgi-fcgi -y
yum install php-core -y
yum install php-ctype -y
yum install php-date -y
yum install php-exif -y
yum install php-fileinfo -y
yum install php-filter -y
yum install php-ftp -y
yum install php-gettext -y
yum install php-gmp -y
yum install php-hash -y
yum install php-iconv -y
yum install php-libxml -y
yum install php-openssl -y
yum install php-pcntl -y
yum install php-pcre -y
yum install php-phar -y
yum install php-readline -y
yum install php-reflection -y
yum install php-session -y
yum install php-shmop -y
yum install php-simplexml -y
yum install php-sockets -y
yum install php-spl -y
yum install php-sqlite3 -y
yum install php-standard -y
yum install php-tokenizer -y
yum install php-xml -y
yum install php-zlib -y
yum install php-curl -y
yum install php-dom -y
yum install php-gd -y
yum install php-json -y
yum install php-mbstring -y
yum install php-mcrypt -y
yum install php-mysqli -y
yum install php-mysqlnd -y
yum install php-opcache -y
yum install php-pdo -y
yum install php-pdo_mysql -y
yum install php-soap -y
yum install php-xmlrpc -y

# Рестарт
systemctl restart php-fpm
systemctl restart nginx

# Установка mySQL
yum install mariadb-server mariadb-client -y
systemctl start mariadb

# Установка Redis
yum install redis -y

# Автозагрузка
systemctl enable php-fpm
systemctl enable nginx
systemctl enable mariadb.service
