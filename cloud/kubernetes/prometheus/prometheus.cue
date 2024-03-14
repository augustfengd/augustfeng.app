package prometheus

prometheus: manifests: [{
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "Prometheus"
	metadata: name:     "prometheus"
	labels: prometheus: "prometheus"
	spec: replicas:     1
	serviceAccountName: "prometheus"
	alerting: alertmanagers: [{
		namespace: "system-monitoring"
		name:      "alertmanager"
		port:      "web"
	}]
}]
