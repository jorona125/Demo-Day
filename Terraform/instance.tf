resource "aws_instance" "web_server" {
        ami             = "ami-0cff7528ff583bf9a"
        instance_type   = "t2.micro"
        user_data       = <<-EOF
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












                          EOF
}

output "DNS" {
        value = aws_instance.web_server.public_dns
}

resource "aws_key_pair" "demo" {
    key_name = "demo"
    public_key = "	da:eb:eb:1f:b4:6a:37:f0:68:16:d2:c8:21:95:ba:7d:f5:e8:27:cf"
  
}