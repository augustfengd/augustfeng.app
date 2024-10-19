resource "aws_vpc" "compute" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "compute"
  }
}

resource "aws_identitystore_user" "augustfengd" {
  identity_store_id = "d-9067d66925"

  display_name = "August Feng"
  user_name    = "augustfengd"

  name {
    given_name  = "August"
    family_name = "Feng"
  }

  emails {
    value = "augustfengd@gmail.com"
  }
}
