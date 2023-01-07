resource "aws_instance" "main-instance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"

  subnet_id = aws_subnet.main-public-1

  # vpc_security_group_ids = 
}
