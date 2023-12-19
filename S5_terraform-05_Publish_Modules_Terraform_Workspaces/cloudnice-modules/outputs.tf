output "instance_public_ip" {
  value = aws_instance.tfmyec2.*.public_ip
}

output "secgrbid" {
  value = aws_security_group.tf-sec-grp.id
}

output "instance_id" {
  value = aws_instance.tfmyec2.*.id
}