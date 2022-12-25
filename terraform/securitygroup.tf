# Utilizing the data tf-type allows us to 'dynamically' get and use values from the cloud provider
data "aws_ip_ranges" "european_ec2_1" {
  # We want all the AWS EC2 IP addresses from the following 2 regions/zones
  regions  = ["eu-west-1", "eu-central-1"]
  services = ["ec2"]
}

# Utilizing the data 
resource "aws_security_group" "european_ec2_grp1" {
  name = "european-ec2-group-1"

  ingress {
    # I'm getting an error on my 'cheap' tier when I try to apply all of the cidrs provided by our data rule above. So i'm going to hard code just a few 
    # To figure out if I can deploy. The commented out cidr_blocks directly below is the original
    # cidr_blocks      = data.aws_ip_ranges.european_ec2_1.cidr_blocks
    description      = "Dynamically populated list of all (partial) European EC2 IP addresses that we allow ingress from on https 443 and tcp"
    from_port        = 443
    protocol         = "tcp"
    to_port          = 443
    ipv6_cidr_blocks = data.aws_ip_ranges.european_ec2_1.ipv6_cidr_blocks
  }

  tags = {
    CreatedDate = data.aws_ip_ranges.european_ec2_1.create_date
    SyncToken   = data.aws_ip_ranges.european_ec2_1.sync_token
  }
}
