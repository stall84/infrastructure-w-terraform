terraform {
  backend "s3" {
    key = "tutorial-backend-1"
  }
}

# To further expand and practice with variable usage and conventions. Let's make a trivial example where we will split out
# a couple of AWS secrets into separate files 
provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION

}
