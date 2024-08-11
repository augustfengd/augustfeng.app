package terraform

lib: gcp: {

	#gcp: {
		cluster: {
			name:     string
			location: string
		}
		iam: [string]: {
			account_id: string
			roles: [...string]
			display_name: string | *""
			workloadIdentity: {
				namespace:      string
				serviceaccount: string
			} | *null
			key: bool | *false
		}
	}

	data: {
		google_project: "project": {}
	}

	// Cloud DNS
	resource: {
		google_dns_managed_zone: "augustfeng-app": {
			name:          "augustfeng-app"
			dns_name:      "augustfeng.app."
			force_destroy: true
		}
		google_dns_record_set: "augustfeng-app": {
			name: "${google_dns_managed_zone.augustfeng-app.dns_name}"
			type: "A"
			ttl:  300

			managed_zone: "${google_dns_managed_zone.augustfeng-app.name}"

			rrdatas: ["0.0.0.0"] // a controller is expected to manage this.
			lifecycle: ignore_changes: ["rrdatas"]
		}
	}

	// Google Kubernetes Engine
	resource: {
		google_service_account: "augustfeng-app": {
			account_id:   "augustfeng-app"
			display_name: "augustfeng-app"
		}

		google_container_cluster: "augustfeng-app": {
			name:     #gcp.cluster.name
			location: #gcp.cluster.location

			initial_node_count: 1

			node_config: {
				machine_type: "e2-micro"
				disk_size_gb: "10"
				disk_type:    "pd-standard"

				service_account: "${google_service_account.augustfeng-app.email}"
				oauth_scopes: [
					"https://www.googleapis.com/auth/cloud-platform",
				]
			}
			workload_identity_config: {
				workload_pool: "${data.google_project.project.project_id}.svc.id.goog"
			}
		}
		google_container_node_pool: "e2-micro": {
			name:       "e2-small-pool"
			cluster:    "${google_container_cluster.augustfeng-app.id}"
			node_count: 0

			node_config: {
				spot:         true
				machine_type: "e2-small"
				disk_size_gb: "10"
				disk_type:    "pd-standard"

				// Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
				service_account: "${google_service_account.augustfeng-app.email}"
				oauth_scopes: [
					"https://www.googleapis.com/auth/cloud-platform",
			]
			}
		}


		google_container_node_pool: "e2-small": {
			name:       "e2-small-pool"
			cluster:    "${google_container_cluster.augustfeng-app.id}"
			node_count: 1

			node_config: {
				spot:         true
				machine_type: "e2-small"
				disk_size_gb: "10"
				disk_type:    "pd-standard"

				// Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
				service_account: "${google_service_account.augustfeng-app.email}"
				oauth_scopes: [
					"https://www.googleapis.com/auth/cloud-platform",
				]
			}
		}

		google_container_node_pool: "e2-medium": {
			name:       "e2-medium-pool"
			cluster:    "${google_container_cluster.augustfeng-app.id}"
			node_count: 1

			node_config: {
				spot:         true
				machine_type: "e2-medium"
				disk_size_gb: "10"
				disk_type:    "pd-standard"

				// Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
				service_account: "${google_service_account.augustfeng-app.email}"
				oauth_scopes: [
					"https://www.googleapis.com/auth/cloud-platform",
			]
			}
		}

		google_compute_firewall: "ingress": {
			name:    "augustfeng-app-https"
			network: "default"

			source_ranges: ["0.0.0.0/0"]

			target_service_accounts: ["${google_service_account.augustfeng-app.email}"]
			allow: {
				protocol: "tcp"
				ports: ["443"]
			}
		}
	}

	resource: {
		for sa, c in #gcp.iam {
			google_service_account: (sa): {
				account_id:   c.account_id
				display_name: c.display_name
			}
			for i, r in c.roles {
				google_project_iam_member: "\(sa)-\(i)": {
					project: "augustfengd"
					role:    (r)
					member:  "serviceAccount:${google_service_account.\(sa).email}"
				}
			}
			if c.workloadIdentity != null {
				google_service_account_iam_member: "workload-identity-\(sa)": {
					service_account_id: "${google_service_account.\(sa).name}"
					role:               "roles/iam.workloadIdentityUser"
					member:             "serviceAccount:" + "${data.google_project.project.project_id}" + ".svc.id.goog[" + (c.workloadIdentity.namespace) + "/" + (c.workloadIdentity.serviceaccount) + "]"
				}
			}

			if c.key {
				google_service_account_key: (sa): service_account_id: "${google_service_account.\(sa).name}"
			}
		}
	}

	terraform: required_providers: {
		google: {
			source:  "hashicorp/google"
			version: "4.68.0"
		}
	}

	provider: google: {
		project: "augustfengd"
	}
}
