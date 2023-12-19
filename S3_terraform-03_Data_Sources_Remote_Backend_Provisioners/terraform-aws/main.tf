provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.30.0"
    }
  }
}

locals {
  mytag = "mmt-local-name"
}

data "aws_ami" "mmt_ami" {
  most_recent      = true
  owners           = ["self"]


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "ec2_type" {
  default = "t2.micro"
}

resource "aws_instance" "tf-ec2" {
  ami           = data.aws_ami.mmt_ami.id
  instance_type = var.ec2_type
  key_name      = "firstkey"
  tags = {
    Name = "${local.mytag}-this is from my-ami"
  }
}