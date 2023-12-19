terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.30.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


variable "tf-ami" {
  type = list(string)
  default = ["ami-079db87dc4c10ac91", "ami-0fc5d935ebf8bc3bc", "ami-026ebd4cfe2c043b2"]
}

variable "tf-tags" {
  type = list(string)
  default = ["aws-linux-2023", "ubuntu-22.04", "red-hat-linux-9"]
}



resource "aws_instance" "tf-instances" {
    ami = element(var.tf-ami, count.index)
    count = 3
    instance_type = "t2.micro"
    key_name = "keypair"
    vpc_security_group_ids = [ aws_security_group.tf-sg.id ]
    tags = {
      Name = element(var.tf-tags, count.index)
    }
  
}


resource "aws_security_group" "tf-sg" {
  name = "tf-import-sg"
  description = "terraform import security group"
  tags = {
    Name = "tf-import-sg"
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 90
    protocol    = "tcp"
    to_port     = 90
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}