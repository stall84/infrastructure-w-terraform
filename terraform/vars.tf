# We're declaring the variables we will use in our build process here but not assigning any values.

variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

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
# testing substitutions
