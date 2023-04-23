package augustfeng_app

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/terraform"
	sec "github.com/augustfengd/augustfeng.app/secrets"
)

configuration: terraform.configuration & {
	terraform.lib.gcp & {
		#gcp: cluster: {
			name:     "augustfeng-app"
			location: "us-east1-b"
		}
		#gcp: iam: {
			"ci-cd-pipeline": {
				account_id:   "ci-cd-pipeline"
				display_name: "ci-cd-pipeline"
				roles: ["roles/container.admin"]
				key: true
			}
			"cert-manager": {
				account_id:   "cert-manager"
				display_name: "cert-manager"
				roles: ["roles/dns.admin"]
				workloadIdentity: {
					namespace:      "system-ingress"
					serviceaccount: "cert-manager"
				}
			}
			"domain-controller": {
				account_id:   "domain-controller"
				display_name: "domain-controller"
				roles: ["roles/dns.admin"]
				workloadIdentity: {
					namespace:      "system-ingress"
					serviceaccount: "domain-controller"
				}
			}
		}
	}
	terraform.lib.github & {
		#github: secrets: GOOGLE_CREDENTIALS: "${base64decode(google_service_account_key.ci-cd-pipeline.private_key)}"
	}
	terraform.lib.kubernetes & {
		#kubernetes: cluster: {
			name:     "augustfeng-app"
			location: "us-east1-b"
		}
		#kubernetes: namespaces: {
			"system-ingress": {}
			// "system-gitops": {}
			// "system-metrics": {}
			// "system-visualization": {}
			// "system-logging": {}

			// applications
			"blog": {}
		}
	}
	"terraform": cloud: {
		organization: "augustfengd"
		hostname:     "app.terraform.io"
		workspaces: {
			name: "augustfeng-app"
		}
		token: sec["terraform-cloud-secrets.json"]["TF_TOKEN_app_terraform_io"]

		// for terraform_tool.cue

		//HACK: these fields should not be rendered, but still accessible.
		//so, we use piggyback on #.
		#settings: "terraform-version": string | *"1.4.5"
		#vars: [
			{
				key:       "GITHUB_TOKEN"
				value:     sec["github-secrets.json"].GITHUB_TOKEN
				category:  "env"
				sensitive: true
			},
			{
				key:       "GOOGLE_CREDENTIALS"
				value:     sec["google-credentials.json"].GOOGLE_CREDENTIALS
				category:  "env"
				sensitive: true
			},
		]
	}
}
