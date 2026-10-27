terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.63.0"
    }
  }
}

provider "aws" {
   region = var.region
}

resource "aws_instance" "myserver" {
    ami = "ami-0faf2b6e64f313b65"
    instance_type = "t2.nano"
    
    tags = {
      name = "sampleserver"
    }
  
}