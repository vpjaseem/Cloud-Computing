sudo yum update -y
sudo yum install httpd -y
sudo yum install php -y
sudo chmod 777 /$home/var/www/html/
sudo service httpd start
sudo chkconfig httpd on
sudo yum install git -y
