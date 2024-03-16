package prometheus

prometheus: manifests: [{
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "Prometheus"
	metadata: name: "prometheus"
	spec: {
		replicas: 1
		serviceMonitorSelector: {}
		alerting: alertmanagers: [{
			namespace: "system-monitoring"
			name:      "alertmanager"
			port:      "web"
		}]
		serviceAccountName: "prometheus"
	}
}]
