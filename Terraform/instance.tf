resource "aws_instance" "Demoinstance-1" {
    ami           = "ami-051dcca84f1edfff1"
    instance_type = "t2.micro"
}