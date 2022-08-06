#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo yum install php -y
sudo chmod 777 /$home/var/www/html/
sudo service httpd start
sudo chkconfig httpd on

cd /$home/var/www/html/
sudo wget "https://github.com/vpjaseem/az-lin-php-web-app/archive/refs/heads/main.zip"
sudo unzip main.zip
sudo mv az-lin-php-web-app-main/* /$home/var/www/html/
sudo rm -r -f az-lin-php-web-app-main
rm -f main.zip
sudo service httpd restart
