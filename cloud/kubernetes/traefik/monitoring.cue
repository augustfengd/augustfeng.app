package traefik

monitoring: manifests: [{
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ServiceMonitor"
	metadata: {
		name:      "traefik"
		namespace: "system-monitoring"
	}
	spec: {
		namespaceSelector: matchNames: ["system-ingress"]
		selector: matchLabels: "app.kubernetes.io/name": "traefik"
		endpoints: [{port: "dashboard"}]
	}
}]
