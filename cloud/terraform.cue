package terraform

import (
	s "github.com/augustfengd/augustfeng.app/cloud/secrets"
)

configuration: {
	// list of possible blocks: https://github.com/hashicorp/terraform-schema/blob/main/internal/schema/0.12/root.go#L18
	"data"?: {}
	"resource"?: {}
	"terraform"?: {
		cloud: {
			organization: "augustfengd"
			hostname:     "app.terraform.io"
			workspaces: {
				name: "augustfeng-app"
			}
			token: s["terraform-cloud-secrets.json"]["TF_TOKEN_app_terraform_io"]

			// for terraform_tool.cue

			//HACK: these fields should not be rendered, but still accessible.
			//so, we use piggyback on #.
			#settings: "terraform-version": string | *"1.2.7"
			#vars: [
				{
					key:       "GITHUB_TOKEN"
					value:     s["github-secrets.json"].GITHUB_TOKEN
					category:  "env"
					sensitive: true
				},
				{
					key:       "NAMECHEAP_USER_NAME"
					value:     s["namecheap-secrets.json"].user_name
					category:  "env"
					sensitive: true
				},
				{
					key:       "NAMECHEAP_API_USER"
					value:     s["namecheap-secrets.json"].api_user
					category:  "env"
					sensitive: true
				},
				{
					key:       "NAMECHEAP_API_KEY"
					value:     s["namecheap-secrets.json"].api_key
					category:  "env"
					sensitive: true
				},
				{
					key:       "DIGITALOCEAN_TOKEN"
					value:     s["digitalocean-secrets.json"].token
					category:  "env"
					sensitive: true
				},
				{
					key:       "GOOGLE_CREDENTIALS"
					value:     s["google-credentials.json"].GOOGLE_CREDENTIALS
					category:  "env"
					sensitive: true
				},
			]
		}
	}
	"module"?: {}
	"locals"?: {}
	"provider"?: {}
	"output"?: {}
	"variable"?: {}
}
