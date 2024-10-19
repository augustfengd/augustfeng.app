locals {
  aws_ssoadmin_instance_arn = "arn:aws:sso:::instance/ssoins-7223dea311e105c1"
  aws_identity_store_id     = "d-9067d66925"
}

data "aws_caller_identity" "default" {}

resource "aws_vpc" "compute" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "compute"
  }
}

resource "aws_identitystore_user" "augustfengd" {
  identity_store_id = local.aws_identity_store_id

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

resource "aws_ssoadmin_account_assignment" "augustfengd" {
  instance_arn       = local.aws_ssoadmin_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.AdministratorAccess.arn

  principal_id   = aws_identitystore_user.augustfengd.id
  principal_type = "USER"

  target_id   = data.aws_caller_identity.default.account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_permission_set" "AdministratorAccess" {
  name         = "AdministratorAccess"
  instance_arn = local.aws_ssoadmin_instance_arn
}

resource "aws_ssoadmin_managed_policy_attachment" "AdministratorAccess" {
  depends_on = [aws_ssoadmin_account_assignment.augustfengd]

  instance_arn       = local.aws_ssoadmin_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.AdministratorAccess.arn
}
