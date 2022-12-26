
output "public_ip" {
  value = aws_instance.main-instance.public_ip
}

output "subnet_id" {
  value = aws_instance.main-instance.subnet_id
}
