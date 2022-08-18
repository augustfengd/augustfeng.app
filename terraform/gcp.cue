package gcp

#c: {
	do_droplets: [string]: string
}

// Cloud DNS
resource: {
	google_dns_managed_zone: "augustfeng": {
		name:     "augustfeng"
		dns_name: "augustfeng.app."
	}

	google_dns_record_set: {
		for droplet, ip in #c.do_droplets {
			"augustfeng-app-\(droplet)": {
				name: "\(droplet).\(resource.google_dns_managed_zone.augustfeng.dns_name)"
				type: "A"

				rrdatas: [ip]

				managed_zone: "${resource.google_dns_managed_zone.augustfeng.name}"
			}
		}
	}
}

// Google Kubernetes Engine
resource: {
	google_service_account: "google-kubernetes-engine": {
		account_id:   "google-kubernetes-engine"
		display_name: "Service Account"
	}

	google_container_cluster: "main": {
		name:     "main"
		location: "us-east1-b"

		initial_node_count: 1

		node_config: {
			preemptible:  true
			machine_type: "e2-micro"

			service_account: "${google_service_account.google-kubernetes-engine.email}"
			oauth_scopes: [
				"https://www.googleapis.com/auth/cloud-platform",
			]
		}
	}

	_google_container_node_pool: "main": {
		name:       "main"
		location:   "us-east1-b"
		cluster:    "${google_container_cluster.main.name}"
		node_count: 1

		node_config: {
			preemptible:  true
			machine_type: "e2-micro"

			service_account: "${google_service_account.google-kubernetes-engine.email}"
			oauth_scopes: [
				"https://www.googleapis.com/auth/cloud-platform",
			]
		}
	}
}

terraform: required_providers: {
	google: {
		source:  "hashicorp/google"
		version: "4.32.0"
	}
}

provider: google: {
	project: "augustfengd"
}
