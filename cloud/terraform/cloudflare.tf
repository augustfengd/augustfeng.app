resource "cloudflare_ruleset" "aws_access_portal" {
  name  = "Redirect from aws.augustfeng.app to AWS access portal"
  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules {
    action     = "redirect"
    expression = "(http.host eq \"aws.augustfeng.app\")"
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
