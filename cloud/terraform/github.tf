resource "github_actions_secret" "GOOGLE_CREDENTIALS" {
  plaintext_value = base64decode(google_service_account_key.ci-cd-pipeline.private_key)
  repository = "augustfeng.app"
  secret_name = "GOOGLE_CREDENTIALS"
}
