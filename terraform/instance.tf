resource "aws_instance" "main-instance" {
  # Practice using a map variable to store our AMI's based on the region the infrastructure is built for
  # Below specifies 1st argument: the map name (AMIS), 2nd argument: the key to retrieve the value for
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.nano"
  # local-exec provisioner will run an local executable on the machine that's running terraform (not on the resource itself.. for that use remote-exec)
  # see https://developer.hashicorp.com/terraform/language/v1.2.x/resources/provisioners/local-exec
  provisioner "local-exec" {
    # command key is required to specifiy a command that will run in the local machine's shell.
    command = "echo ${aws_instance.main-instance.private_ip} >> private_ips.txt"
  }
  # AWS calls any config that is written to the EC2 machine at spin-up/start as 'user_data'  
  # 'user_data' to AWS is similar to CMD or RUN commands in a Dockerfile. Setting config on startup
  # Here Terraform will wait to create this main instance until after the db_instance is created because it can 
  # tell that this instance needs attributes from the db_instance to be written to it on start up.
  user_data = templatefile("templates/init.tpl", {
    # just creating an arbitrarily named variable 'my_ip' to hold the value of the db_instance's private IP 
    my_ip = aws_instance.mock_db_instance.private_ip
    # 'my_ip' will be called in the script in init.tpl and then written to this EC2 machine's file system immediately after it's created.
  })
  key_name = aws_key_pair.ec2_t2nano_keypair1.key_name
}

resource "aws_key_pair" "ec2_t2nano_keypair1" {
  # This is our default 'id_rsa' public key, converted to pem format
  public_key = data.local_file.ec2_key_pem.content
}
