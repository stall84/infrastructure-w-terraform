resource "aws_security_group" "ssh_allow_atl" {
  description = "Add rules to allow ssh specific traffic only from (my) local machine in Atlanta"
  name        = "ssh_allow_atl"

  ingress {
    protocol    = "tcp"
    from_port   = 22 # TODO: Come back later after Instance started and accessed to configure and reset the port to something vague (e.g 2229)
    to_port     = 22
    cidr_blocks = ["162.255.89.199/32"]
    self        = true
  }

  tags = {
    "GeographicLocation" = "Atlanta"
    "use"                = "SSH"
    "for"                = "EC2"
    "port"               = "22"
  }

}
