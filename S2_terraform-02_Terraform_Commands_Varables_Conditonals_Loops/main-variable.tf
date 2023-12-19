terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.30.0"
    }
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"

}


resource "aws_instance" "tf-ec2" {
  ami           = var.ec2_instance_ami
  instance_type = var.ec2_type
  key_name      = "keypair"
  tags = {
    "Name" = "AWS-${var.ec2_name}-instance"
  }

}


resource "aws_s3_bucket" "tf-s3" {
  bucket = "my-bucket-${var.s3_bucket_name}"
}

output "tf_example_public_ip" {
  value = aws_instance.tf-ec2.public_ip
}

output "tf_example_private_ip" {
  value = aws_instance.tf-ec2.private_ip
}

output "tf_s3_meta" {
  value = aws_s3_bucket.tf-s3.bucket
}

