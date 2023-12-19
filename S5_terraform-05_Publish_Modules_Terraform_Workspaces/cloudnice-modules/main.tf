terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon-linux-2023" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "tfmyec2" {
  ami                    = data.aws_ami.amazon-linux-2023.id
  instance_type          = var.instance_type
  count                  = var.number_of_instance
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.tf-sec-grp.id]
  user_data              = templatefile("${abspath(path.module)}/userdata.sh", { myserver = var.server_name })
  tags = {
    "Name" = var.tags
  }
}

resource "aws_security_group" "tf-sec-grp" {
  name = "${var.tags}-terraform-sec-grp"
  tags = {
    "Name" = var.tags
  }

  dynamic "ingress" {
    for_each = var.docker_instance_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

