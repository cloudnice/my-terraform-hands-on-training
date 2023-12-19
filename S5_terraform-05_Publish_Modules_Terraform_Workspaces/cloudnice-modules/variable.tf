variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}
variable "number_of_instance" {
  default = 1
  type    = number
}

variable "tags" {
  type    = string
  default = "Docker-instance"
}

variable "server_name" {
  type    = string
  default = "docker-instance"
}

variable "docker_instance_ports" {
  type        = list(number)
  description = "docker-instance-secgrb-ingress"
  default     = [22, 80, 8080]
}