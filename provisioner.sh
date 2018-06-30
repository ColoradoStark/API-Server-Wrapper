#!/bin/bash

sudo apt-get install python-software-properties -y
sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install php7.2 php7.2-fpm php7.2-mysql -y
sudo apt-get --purge autoremove -y
sudo service php7.2-fpm restart


wget http://dev.mysql.com/get/mysql-apt-config_0.6.0-1_all.deb
export DEBIAN_FRONTEND="noninteractive"


sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5
cat <<- EOF > /etc/apt/sources.list.d/mysql.list
deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7
EOF
sudo apt-get update

sudo apt-get -y install mysql-server mysql-client
sudo service mysql start

sudo apt-get install nginx -y
sudo cat > /etc/nginx/sites-available/default <<- EOM
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    root /vagrant;
    index index.php index.html index.htm;

    server_name server_domain_or_IP;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        try_files \$uri /index.php =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOM
sudo service nginx restart

sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"


