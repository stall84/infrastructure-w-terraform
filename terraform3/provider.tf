terraform {
  backend "s3" {
    # You must use the explicit value for backend configuration. You can't use variables here
    bucket = "terraform-backend-65072-122022"
    key    = "tutorial-backend-3"
  }
}

# To further expand and practice with variable usage and conventions. Let's make a trivial example where we will split out
# a couple of AWS secrets into separate files 
provider "aws" {
  alias      = "main"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION

}
