resource "aws_ami_from_instance" "example" {
  name               = "terraform-example"
  source_instance_id = "i-070a1b421a10466dc"
}