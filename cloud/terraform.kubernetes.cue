package terraform

lib: kubernetes: {
	_kubernetes: {
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

	data: google_container_cluster: cluster: {
		name:     _kubernetes.cluster.name
		location: _kubernetes.cluster.location
	}

	resource: {
		for namespace, configuration in _kubernetes.namespaces {
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
		host:                   "https://${data.google_container_cluster.cluster.endpoint}"
		token:                  "${data.google_client_config.provider.access_token}"
		cluster_ca_certificate: "${base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)}"
	}

	provider: google: {
		project: "augustfengd"
	}
}
