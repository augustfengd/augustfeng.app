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
  identity_store_id = var.aws_identity_store_id

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
  instance_arn       = var.aws_ssoadmin_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.AdministratorAccess.arn

  principal_id   = aws_identitystore_user.augustfengd.user_id
  principal_type = "USER"

  target_id   = data.aws_caller_identity.default.account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_permission_set" "AdministratorAccess" {
  name         = "AdministratorAccess"
  instance_arn = var.aws_ssoadmin_instance_arn
}

resource "aws_ssoadmin_managed_policy_attachment" "AdministratorAccess" {
  depends_on = [aws_ssoadmin_account_assignment.augustfengd]

  instance_arn       = var.aws_ssoadmin_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.AdministratorAccess.arn
}

import {
  to = aws_s3_bucket.augustfengd
  id = "augustfengd"
}

resource "aws_s3_bucket" "augustfengd" {
  bucket = "augustfengd"
}

resource "aws_s3_bucket" "augustfeng-app" {
  bucket = "augustfeng-app"
}

data "aws_iam_policy_document" "augustfeng-app" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]

    resources = [format("%s/blog/*", aws_s3_bucket.augustfeng-app.arn)]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.blog-augustfeng-app.arn]
    }
  }
}


resource "aws_s3_bucket_policy" "augustfeng-app" {
  bucket = aws_s3_bucket.augustfengd.id
  policy = data.aws_iam_policy_document.augustfeng-app.json
}

import {
  id = "E1GWGT4WSSAVAQ"
  to = aws_cloudfront_origin_access_control.sigv4-always-s3
}

resource "aws_cloudfront_origin_access_control" "sigv4-always-s3" {
  name                              = "sigv4-always-s3"
  signing_protocol                  = "sigv4"
  signing_behavior                  = "always"
  origin_access_control_origin_type = "s3"
}

import {
  to = aws_cloudfront_distribution.blog-augustfeng-app
  id = "E2U5ZC18W82IDW"
}

resource "aws_cloudfront_distribution" "blog-augustfeng-app" {
  origin {
    domain_name              = aws_s3_bucket.augustfeng-app.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.sigv4-always-s3.id
    origin_path              = "/blog"
    origin_id                = aws_s3_bucket.augustfeng-app.bucket_regional_domain_name
  }

  aliases = [aws_acm_certificate.blog_augustfeng_app.domain_name]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"


  default_cache_behavior {
    compress               = true
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.augustfeng-app.bucket_regional_domain_name
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6" // Managed-CachingOptimized
  }

  price_class = "PriceClass_All"

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.blog_augustfeng_app.certificate_arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "cloudflare_record" "blog_augustfeng_app" {
  zone_id = var.cloudflare_zone_ids.augustfeng-app
  name    = "blog"
  type    = "CNAME"
  content = aws_cloudfront_distribution.blog-augustfeng-app.domain_name
  ttl     = 1
  proxied = true
}

resource "aws_acm_certificate" "blog_augustfeng_app" {
  domain_name       = "blog.augustfeng.app"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "blog_augustfeng_app" {
  certificate_arn = aws_acm_certificate.blog_augustfeng_app.arn
}

resource "cloudflare_record" "blog_augustfeng_app-validation" {
  for_each = {
    for dvo in aws_acm_certificate.blog_augustfeng_app.domain_validation_options : dvo.domain_name => {
      resource_record_name  = dvo.resource_record_name
      resource_record_value = dvo.resource_record_value
      resource_record_type  = dvo.resource_record_type
    }
  }

  zone_id = var.cloudflare_zone_ids.augustfeng-app
  name    = each.value.resource_record_name
  content = each.value.resource_record_value
  type    = each.value.resource_record_type
}
