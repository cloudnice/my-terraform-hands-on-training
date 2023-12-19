terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.30.0"
    }
  }
  backend "s3" {
    bucket = "tf-remote-s3-bucket-clarusways-mmt"
    key = "env/dev/tf-remote-backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf-s3-app-lock"
    encrypt = true
  }
}
resource "aws_s3_bucket" "tf-bucket" {
  bucket = "mmt-1234567890"
}