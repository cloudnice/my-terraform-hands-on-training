module "docker-instance" {
  source  = "cloudnice/docker-instance/aws"
  version = "0.0.2"
  key_name = "writekeypair"
}