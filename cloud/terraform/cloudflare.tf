resource "cloudflare_ruleset" "single_redirects" {
  zone_id     = var.cloudflare_zone_ids.augustfeng-app
  name        = "redirects"
  description = "Redirects ruleset"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    description = "Redirect from aws.augustfeng.app to AWS access portal"
    expression  = "(http.host eq \"aws.augustfeng.app\")"
    action      = "redirect"
    action_parameters {
      from_value {
        status_code = 301
        target_url {
          value = format("https://%s.awsapps.com/start", var.aws_identity_store_id)
        }
      }
    }
  }
}
