resource "aws_instance" "main-instance" {
  # NOTE: This is a copy from the initial terraform/ folder .. make sure to look at it for the notes I've deleted here
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.nano"

  provisioner "local-exec" {
    # command key is required to specifiy a command that will run in the local machine's shell.
    command = "echo ${aws_instance.main-instance.private_ip} >> private_ips.txt"
  }

  user_data = templatefile("templates/init.tpl", {
    # just creating an arbitrarily named variable 'my_ip' to hold the value of the db_instance's private IP 
    my_ip = aws_instance.mock_db_instance.private_ip
    # 'my_ip' will be called in the script in init.tpl and then written to this EC2 machine's file system immediately after it's created.
  })

  vpc_security_group_ids = [aws_security_group.ssh_allow_atl.id]
  key_name               = "ec2_ssh_12262022"

  # ROUTING-NETWORKING
  # Let's spawn this instance in our specially created main-public-1 subnet
  subnet_id = aws_subnet.main-public-1.id
  # We can then specify the exact IP address we want within our subnet (main-public-1)
  # instead of having AWS automatically assign in (default)
  private_ip = "10.0.1.4" # This will need to be within the subnet we selected's range
}

resource "aws_eip" "example-eip" {
  instance = aws_instance.main-instance.id
  vpc      = true
}
