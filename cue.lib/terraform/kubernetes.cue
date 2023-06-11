package terraform

lib: kubernetes: {

	#kubernetes: {
		cluster: {
			name:     string
			location: string
		}
		namespaces: [string]: {
			annotations: [string]: string
			labels: [string]:      string
		}
	}

	data: google_client_config: provider: {}

	resource: {
		for namespace, configuration in #kubernetes.namespaces {
			// XXX: https://github.com/hashicorp/terraform-provider-kubernetes/issues/1788
			kubernetes_namespace: (namespace): {
				metadata: {
					name: (namespace)
					if len(configuration.annotations) > 0 {
						annotations: (configuration.annotations)
					}
					if len(configuration.labels) > 0 {
						annotations: (configuration.labels)
					}
				}
				depends_on: ["google_container_cluster.augustfeng-app"]
			}
		}
	}
	terraform: required_providers: {
		kubernetes: {
			source:  "hashicorp/kubernetes"
			version: "2.21.1"
		}
	}

	provider: kubernetes: {
		host:                   "https://${google_container_cluster.augustfeng-app.endpoint}"
		token:                  "${data.google_client_config.provider.access_token}"
		cluster_ca_certificate: "${base64decode(google_container_cluster.augustfeng-app.master_auth[0].cluster_ca_certificate)}"
	}

	provider: google: {
		project: "augustfengd"
	}
}
