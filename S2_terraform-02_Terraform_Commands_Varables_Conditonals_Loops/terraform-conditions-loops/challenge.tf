provider "aws" {
  region  = "us-east-1"
}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.30.0"
    }
  }
}
variable "users" {
  default = ["santino", "michael", "fredo"]
}
resource "aws_iam_user" "new_users" {
  count = length(var.users)
  name = var.users[count.index]
}