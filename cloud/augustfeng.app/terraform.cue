package terraform

configuration: {
	lib.gcp & {
		_gcp: cluster: {
			name:     "augustfeng-app"
			location: "us-east1-b"
		}
		_gcp: iam: {
			"ci-cd-pipeline": {
				account_id:   "ci-cd-pipeline"
				display_name: "ci-cd-pipeline"
				roles: ["roles/container.admin"]
				key: rotation_days: 30
			}
			"cert-manager": {
				account_id:   "cert-manager"
				display_name: "cert-manager"
				roles: ["roles/dns.admin"]
				workloadIdentity: {
					namespace:      "cert-manager"
					serviceaccount: "cert-manager"
				}
			}
			"external-dns": {
				account_id:   "external-dns"
				display_name: "external-dns"
				roles: ["roles/dns.admin"]
				workloadIdentity: {
					namespace:      "external-dns"
					serviceaccount: "external-dns"
				}
			}
			// replace cert-manager, external-dns
			"system-ingress": {
				account_id:   "system-ingress"
				display_name: "system-ingress"
				roles: ["roles/dns.admin"]
				workloadIdentity: {
					namespace:      "system-ingress"
					serviceaccount: "system-ingress"
				}
			}
		}
	}
	lib.github & {
		_github: secrets: GOOGLE_CREDENTIALS: "${base64decode(google_service_account_key.ci-cd-pipeline.private_key)}"
	}
	lib.kubernetes & {
		_kubernetes: cluster: {
			name:     "augustfeng-app"
			location: "us-east1-b"
		}
		_kubernetes: namespaces: {
			"system-ingress": {}
		}
	}
}
