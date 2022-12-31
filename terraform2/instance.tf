resource "aws_instance" "main-instance" {

  ami           = "ami-0b0ea68c435eb488d"
  instance_type = "t2.nano"
}

