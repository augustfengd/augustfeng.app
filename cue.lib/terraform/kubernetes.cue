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

	// neat trick: this is already declared in gcp.cue and will unify under
	// correct circumstances.
	resource: google_container_cluster: kubernetes: {
		name:     #kubernetes.cluster.name
		location: #kubernetes.cluster.location
	}

	resource: {
		for namespace, configuration in #kubernetes.namespaces {
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
			}
		}
	}

	provider: kubernetes: {
		host:                   "https://${google_container_cluster.kubernetes.endpoint}"
		token:                  "${data.google_client_config.provider.access_token}"
		cluster_ca_certificate: "${base64decode(google_container_cluster.kubernetes.master_auth[0].cluster_ca_certificate)}"
	}

	provider: google: {
		project: "augustfengd"
	}
}
