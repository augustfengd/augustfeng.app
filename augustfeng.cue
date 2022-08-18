package augustfeng

import (
	"github.com/augustfengd/augustfeng.app/terraform/secrets:secrets"
	t "github.com/augustfengd/augustfeng.app/terraform:terraform"
)

actions: {} // use defaults.

terraform: t.#c & {
	configuration: {
		"do": "k3s": {
			agent_pool: [{name: "k3s-agent-0"}]
		}
		"gcp": {
			do_droplets: {for droplet in (configuration["do"]["k3s"].server_pool + configuration["do"]["k3s"].agent_pool) {(droplet.name): "${digitalocean_droplet.\(droplet.name).ipv4_address}"}}
		}
	}
	workspace: {
		organization: "augustfengd"
		name:         "augustfeng-app"
		vars: [
			{
				key:       "NAMECHEAP_USER_NAME"
				value:     secrets["namecheap-secrets.json"].user_name
				category:  "env"
				sensitive: true
			},
			{
				key:       "NAMECHEAP_API_USER"
				value:     secrets["namecheap-secrets.json"].api_user
				category:  "env"
				sensitive: true
			},
			{
				key:       "NAMECHEAP_API_KEY"
				value:     secrets["namecheap-secrets.json"].api_key
				category:  "env"
				sensitive: true
			},
			{
				key:       "DIGITALOCEAN_TOKEN"
				value:     secrets["digitalocean-secrets.json"].token
				category:  "env"
				sensitive: true
			},
			{
				key:       "GOOGLE_CREDENTIALS"
				value:     secrets["google-credentials.json"].GOOGLE_CREDENTIALS
				category:  "env"
				sensitive: true
			},
		]
		token: secrets["terraform-cloud-secrets.json"].TF_TOKEN_app_terraform_io
	}
}
