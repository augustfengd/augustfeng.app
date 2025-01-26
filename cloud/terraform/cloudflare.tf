resource "cloudflare_record" "aws" {
  zone_id = var.cloudflare_zone_ids.augustfeng-app
  name    = "aws"
  content = format("%s.awsapps.com/start", var.aws_identity_store_id)
  type    = "CNAME"
  ttl     = 3600
}
