resource "aws_instance" "example-instance" {
  # Practice using a map variable to store our AMI's based on the region the infrastructure is built for
  # Below specifies 1st argument: the map name (AMIS), 2nd argument: the key to retrieve the value for
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
}
