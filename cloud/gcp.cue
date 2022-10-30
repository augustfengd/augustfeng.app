package terraform

lib: gcp: {
	// Cloud DNS
	resource: {
		google_dns_managed_zone: "augustfeng": {
			name:     "augustfeng"
			dns_name: "augustfeng.app."
		}
	}

	// Google Kubernetes Engine
	resource: {
		google_service_account: "cluster": {
			account_id:   "augustfeng-app-cluster"
			display_name: "Service Account"
		}

		google_container_cluster: "cluster": {
			name:     "augustfeng-app"
			location: "us-east1-b"

			initial_node_count: 1

			node_config: {
				preemptible:  true
				machine_type: "e2-micro"

				service_account: "${google_service_account.cluster.email}"
				oauth_scopes: [
					"https://www.googleapis.com/auth/cloud-platform",
				]
			}
		}
	}

	terraform: required_providers: {
		google: {
			source:  "hashicorp/google"
			version: "4.41.0"
		}
	}

	provider: google: {
		project: "augustfengd"
	}
}
