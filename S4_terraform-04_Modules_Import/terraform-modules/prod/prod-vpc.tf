module "tf-vpc" {
  source = "../modules"
  environment = "PROD"
}

output "vpc_cidr_block" {
  value = module.tf-vpc.vpc_cidr
}


########################################

# resource "aws_security_group" "name" {
#   name = "prod-vpc-sec-gr"
#   vpc_id = module.tf-vpc.vpc_id

#   tags = {
#     Name = "prod-vpc-sec-gr"
#   }

#   ingress {
#     from_port = 80
#     to_port = 90
#     protocol = "tcp"
#     self = true
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = [ "0.0.0.0/0" ]
#   }

# }