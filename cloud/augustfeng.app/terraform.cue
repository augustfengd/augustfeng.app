package terraform

configuration: {
	lib.gcp & {
		_gcp: iam: {
			"ci-cd-pipeline": {
				account_id:   "ci-cd-pipeline"
				display_name: "GitHub Actions service account"
				roles: ["roles/container.admin"]
				key: rotation_days: 30
			}
			"cert-manager": {
				account_id:   "cert-manager"
				display_name: "cert-manager service account"
				roles: ["roles/dns.admin"]
				workloadIdentity: {
					namespace:      "cert-manager"
					serviceaccount: "cert-manager"
				}
			}
		}
	}
	lib.github & {
		_github: secrets: GOOGLE_CREDENTIALS: "${base64decode(google_service_account_key.ci-cd-pipeline.private_key)}"
	}
}
