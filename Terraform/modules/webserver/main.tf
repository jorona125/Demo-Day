module "iam_instance_profile" {
  source  = "terraform-in-action/iip/aws"
  actions = ["logs:*", "rds:*"]
}


resource "aws_launch_template" "webserver" {
  name_prefix   = var.project_name
  image_id      = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  user_data     = base64encode(file("${path.module}/script.sh"))
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
  launch_template {
    id      = aws_launch_template.webserver.id
    version = aws_launch_template.webserver.latest_version
  }
}

resource "aws_elb" "my-elb" {
  name            = "my-elb"
  subnets         = [var.vpc.public_subnets[0], var.vpc.public_subnets[1], var.vpc.public_subnets[2]]
  security_groups = [var.sg.lb]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }
}



