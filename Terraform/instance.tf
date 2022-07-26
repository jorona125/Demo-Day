resource "aws_instance" "web_app1" {
    ami           = "ami-051dcca84f1edfff1"
    instance_type = "t2.micro"
}

resource "aws_instance" "web_app2" {
    ami = "ami-051dcca84f1edfff1"
    instance_type = "t2.micro"
    }
  


resource "aws_instance" "web_app3" {
    ami = "ami-051dcca84f1edfff1"
    instance_type = "t2.micro"
}