terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.63.0"
    }
  }
}

provider "aws" {
   region = "ap-south-1"
}

resource "aws_s3_bucket" "demo-bucket" {
    bucket = "demo-bucket-abc666" 
}


resource "aws_s3_bucket_object" "bucket-data" {
  bucket = aws_s3_bucket.demo-bucket.id
  source = "./myfile.txt"
  key = "mydata.txt"
}
