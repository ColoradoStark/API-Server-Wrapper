#!/bin/bash

sudo apt-get install python-software-properties -y
sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php -y
sudo apt-get update

sudo apt-get install php7.2 php7.2-fpm php7.2-mysql php7.2-xml -y
sudo apt-get --purge autoremove -y
sudo service php7.2-fpm restart


#export DEBIAN_FRONTEND="noninteractive"


#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

#sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8C718D3B5072E1F5
#cat <<- EOF > /etc/apt/sources.list.d/mysql.list
#deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7
#EOF
#sudo apt-get update

export DEBIAN_FRONTEND=noninteractive

MYSQL_ROOT_PASSWORD='root' # SET THIS! Avoid quotes/apostrophes in the password, but do use lowercase + uppercase + numbers + special chars

# Install MySQL
# Suggestion from @dcarrith (http://serverfault.com/a/830352/344471):
echo debconf mysql-server/root_password password $MYSQL_ROOT_PASSWORD | sudo debconf-set-selections
echo debconf mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD | sudo debconf-set-selections
#sudo debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
#sudo debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
sudo apt-get -qq install mysql-server > /dev/null # Install MySQL quietly

# Install Expect
sudo apt-get -qq install expect > /dev/null

# Build Expect script
tee ~/secure_our_mysql.sh > /dev/null << EOF
spawn $(which mysql_secure_installation)

expect "Enter password for user root:"
send "$MYSQL_ROOT_PASSWORD\r"

expect "Press y|Y for Yes, any other key for No:"
send "y\r"

expect "Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG:"
send "2\r"

expect "Change the password for root ? ((Press y|Y for Yes, any other key for No) :"
send "n\r"

expect "Remove anonymous users? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Disallow root login remotely? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Remove test database and access to it? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Reload privilege tables now? (Press y|Y for Yes, any other key for No) :"
send "y\r"

EOF

# Run Expect script.
# This runs the "mysql_secure_installation" script which removes insecure defaults.
sudo expect ~/secure_our_mysql.sh

# Cleanup
rm -v ~/secure_our_mysql.sh # Remove the generated Expect script
#sudo apt-get -qq purge expect > /dev/null # Uninstall Expect, commented out in case you need Expect

echo "MySQL setup completed. Insecure defaults are gone. Please remove this script manually when you are done with it (or at least remove the MySQL root password that you put inside it."


#sudo apt-get -y install mysql-server mysql-client
sudo service mysql start

sudo apt-get install nginx -y
sudo cat > /etc/nginx/sites-available/default <<- EOM
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    root /usr/share/nginx/html;
    index index.php index.html index.htm;

    server_name server_domain_or_IP;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        try_files \$uri /index.php =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOM
sudo service nginx restart

#sudo mkdir /usr/share/nginx/html/API
sudo chown ubuntu:ubuntu /usr/share/nginx/html #/API
#echo "ubuntu:ubuntu" | sudo chpasswd

cd /usr/share/nginx/html #/API
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --prefer-dist
php -r "unlink('composer-setup.php');"

#sudo apt-get install php7.2-xml
php composer.phar create-project slim/slim-skeleton API

# Status Reports
ps aux | grep php-fpm
service mysql status
service nginx status
