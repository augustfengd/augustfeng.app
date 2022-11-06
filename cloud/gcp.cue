package terraform

lib: gcp: {

	_gcp: {
		iam: [string]: {
			account_id: string
			roles: [...string]
			display_name:     string | *""
			workloadIdentity: {
				namespace:      string
				serviceaccount: string
			} | *null
			key: {
				rotation_days: number
			} | *null
		}
	}

	data: {
		google_project: "project": {}
	}

	// Cloud DNS
	resource: {
		google_dns_managed_zone: "augustfeng": {
			name:          "augustfeng"
			dns_name:      "augustfeng.app."
			force_destroy: true
		}
	}

	// Google Kubernetes Engine
	resource: {
		google_service_account: "cluster": {
			account_id:   "augustfeng-app-cluster"
			display_name: "augustfeng-app-cluster"
		}

		google_container_cluster: "cluster": {
			name:     "augustfeng-app"
			location: "us-east1-b"

			initial_node_count: 1

			node_config: {
				machine_type: "e2-micro"

				service_account: "${google_service_account.cluster.email}"
				oauth_scopes: [
					"https://www.googleapis.com/auth/cloud-platform",
				]
			}
			workload_identity_config: {
				workload_pool: "${data.google_project.project.project_id}.svc.id.goog"
			}
		}

		google_container_node_pool: "e2-small": {
			name:       "e2-small-pool"
			cluster:    "${google_container_cluster.cluster.id}"
			node_count: 1

			node_config: {
				spot:         true
				machine_type: "e2-small"

				// Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
				service_account: "${google_service_account.cluster.email}"
				oauth_scopes: [
					"https://www.googleapis.com/auth/cloud-platform",
				]
			}
		}
	}

	resource: {
		for sa, c in _gcp.iam {
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

			if c.key != null {
				google_service_account_key: (sa): {
					service_account_id: "${google_service_account.\(sa).name}"
					keepers: {
						rotation_time: "${time_rotating.\(sa)-rotation.rotation_rfc3339}"
					}
				}
				time_rotating: "\(sa)-rotation": {
					rotation_days: c.key.rotation_days
				}
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
