
output "public_ip" {
  value = aws_instance.example-instance.public_ip
}

output "subnet_id" {
  value = aws_instance.example-instance.subnet_id
}
