
#!/bin/bash
sudo su
yum update -y
yum -y install httpd
yum install -y amazon-linux-extras php
amazon-linux-extras enable php8.0
systemctl enable httpd
systemctl start httpd
wget https://www.drupal.org/download-latest/zip
unzip zip
mv /drupal-*/.* /var/www/html/
mv -v /drupal-*/* /var/www/html/
chown -R apache:apache /var/www/html/
cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php
chmod a+w /var/www/html/sites/default/settings.php
chmod a+w /var/www/html/sites/default
sudo service httpd restart
sudo service httpd start