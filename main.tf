# Define the provider (AWS in this case)
provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}


resource "aws_instance" "web_server" {
  ami           = "ami-03a6eaae9938c858c"  # Replace with the desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = "subnet-029f8ef1dcda72121"
  security_groups = ["sg-0c5027ac5fe96c494"]
  key_name = "OELabIPM"

}

output "Ip" {
    value = aws_instance.web_server.private_ip
  
}

  
