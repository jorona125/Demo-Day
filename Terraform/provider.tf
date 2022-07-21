terraform {
  required_providers {
    aws = {
        source = "aws"
        version = "~> 4.22.0"
    }
    }
  }

provider "aws" {
    region = "us-east-1"
  
}


