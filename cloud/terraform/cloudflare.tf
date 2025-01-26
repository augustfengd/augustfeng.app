import {
  to = cloudflare_ruleset.aws_access_portal
  id = "75e452482817c1c147830ac917e3cc08/60b251bcbeb34a0eab96efb9500822fd"
}

resource "cloudflare_ruleset" "aws_access_portal" {
  name  = "Redirect from aws.augustfeng.app to AWS access portal"
  kind  = "redirect"
  phase = "http_request_late_transform"
}
