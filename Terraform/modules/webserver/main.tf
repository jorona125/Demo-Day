module "iam_instance_profile" {
  source  = "terraform-in-action/iip/aws"
  actions = ["logs:*", "rds:*"]
}


resource "aws_launch_template" "webserver" {
  name_prefix   = var.project_name
  image_id      = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  user_data     =  <<-EOF
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
  key_name      = var.ssh_keypair
  iam_instance_profile {
    name = module.iam_instance_profile.name
  }
  vpc_security_group_ids = [var.sg.websvr]
}
resource "aws_autoscaling_group" "webserver" {
  name                = "${var.project_name}-asg"
  min_size            = 1
  max_size            = 3
  vpc_zone_identifier = var.vpc.private_subnets
  target_group_arns   = module.alb.target_group_arns
  launch_template {
    id      = aws_launch_template.webserver.id
    version = aws_launch_template.webserver.latest_version
  }
}

module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "~> 5.0"
  name               = var.project_name
  load_balancer_type = "application"
  vpc_id             = var.vpc.vpc_id
  subnets            = var.vpc.public_subnets
  security_groups    = [var.sg.lb]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    { name_prefix      = "websvr"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
    }
  ]
}
