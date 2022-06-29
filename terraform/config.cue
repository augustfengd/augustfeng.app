package config

import (
	"github.com/augustfengd/augustfeng.app/terraform/secrets:secrets"
)

terraform: {
	workspace: _#terraformWorkspace & {
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
		]
	}
}

_#terraformWorkspace: {
	organization: string
	hostname:     string | *"app.terraform.io"
	name:         string
	settings:     _#terraformWorkspaceSettings
	vars: [... _#terraformWorkspaceVar]
}

_#terraformWorkspaceSettings: {
	"terraform-version": string | *"1.2.0"
}

_#terraformWorkspaceVar: {
	key:          string
	value:        string
	category:     "hcl" | "env"
	sensitive:    bool | *false
	description?: string
}
