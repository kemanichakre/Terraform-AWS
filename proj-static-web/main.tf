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

resource "aws_s3_bucket" "mywebapp-bucket" {
    bucket = "mywebapp-bucket-abc666" 
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {
bucket = aws_s3_bucket.mywebapp-bucket.id
policy = jsonencode(
    {
    Version = "2012-10-17",
    Statement = [
        {
            Sid        = "PublicReadGetObject",
            Effect     = "Allow",
            Principal  = "*",
            Action     = "s3:GetObject",
            Resource   =  "arn:aws:s3:::mywebapp-bucket-abc666/*"
            
        }
    ]
}
)
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  index_document {
    suffix = "index.html"
  }

}


resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.mywebapp-bucket.id
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "styles_css" {
  bucket = aws_s3_bucket.mywebapp-bucket.id
  source = "./styles.css"
  key = "styles.css"
  content_type = "text/css"
}