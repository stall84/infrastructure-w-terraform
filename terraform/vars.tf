# We're declaring the variables we will use in our build process here but not assigning any values.

variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "BACKEND_BUCKET" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0b0ea68c435eb488d"
    us-west-2 = "ami-0688ba7eeeeefe3cd"
    eu-west-1 = "ami-0f29c8402f8cce65c"
  }
}
# ENV Variables can be loaded using the 'external' data source (shown below) 
# https://support.hashicorp.com/hc/en-us/articles/4547786359571-Reading-and-using-environment-variables-in-Terraform-runs
# It's also possible though to read env vars off the runtim that are prefixed 
# with 'TF_VAR...' ex 'TF_VAR_MYID=aJUladi(0
# they still have to be declared like any other variable/substitution in terraform
variable "TV_VAR_EU_WEST_1" {
  # If our desired EU_WEST_1 doesn't exist in our environment vars.. then default to eu-west-2 as a next-best region
  default = "eu-west-2"
}

data "local_file" "ec2_key_pem" {
  filename = "/Users/mstallings/.ssh/id_rsa.pem"
}
