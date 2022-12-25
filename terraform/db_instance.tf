## Initially lets use this 'mock_db_instance' to spin up a separate EC2 machine, that will mock a database machine
## We're doing this to utilize templating/templatefile in the main EC2 machine (instance.tf). 

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.TV_VAR_EU_WEST_1

}


resource "aws_instance" "mock_db_instance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.nano"
  tags          = ["cool", "db_instance", "bill_me", "nano", "t2"]
}
