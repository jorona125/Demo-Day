resource "aws_instance" "servers" {

  lifecycle {
    ignore_changes = [ami, user_data, ebs_block_device, ephemeral_block_device]
  }

  ami = data.aws_ami.ami.id
  key_name = var.key_name
  instance_type = var.instance_type
  subnet_id = var.subnet_ids
  iam_instance_profile = var.iam_instance_profile
  vpc_security_group_ids = var.vpc_security_group_ids
  disable_api_termination = true
  user_data = data.template_file.linux.rendered

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral
    iterator = ephemeral
    content {
      device_name = ephemeral.value
      virtual_name = ephemeral.key      
    }
  }
a
    ebs_block_devices 
    {
    device_name           = var.ebs_name 
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type 
    delete_on_termination = true
    encrypted             = true
  }
  {
    device_name           = var.ebs_name 
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type 
    delete_on_termination = true
    encrypted             = true 
  }
    
    ]

 
}



###variables

variable "ami" {
  default=""
}
variable "key_name" {
  default = ""
}
variable "instance_type" {
  default = ""
}


variable "subnet_ids" {
  default = ""
}

variable "iam_instance_profile"{
  default = ""
} 


variable "vpc_security_group_ids" {
  default = ""
}

variable "ephemeral" {
  default = {}
}

variable "ebs_name" {
  default = ""
}

variable "ebs_volume_type" {
  default = ""
}

variable "ebs_volume_size" {
}


variable "hostnames" {
  default = {}
}


#Tags
variable "project_tags" {
  default = {}
}


