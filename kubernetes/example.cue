package kubernetes

applications: "example": {
	Namespace: {
		"example": {
			apiVersion: "v1"
		}
	}
	Ingress: {
		"nginx": {
			apiVersion: "networking.k8s.io/v1"
			metadata: {
				annotations: "ingress.kubernetes.io/ssl-redirect": "false"
				namespace: Namespace["example"].metadata.name
			}
			spec: rules: [{
				host: "nginx.example.augustfeng.app"
				http: paths: [{
					path:     "/"
					pathType: "Prefix"
					backend: service: {
						name: "nginx"
						port: number: 80
					}
				}]
			}]
		}
	}
	Deployment: {
		"nginx": {
			apiVersion: "apps/v1"
			metadata: {
				namespace: Namespace["example"].metadata.name
			}
			spec: {
				selector: matchLabels: template.metadata.labels
				template: {
					metadata: labels: {
						app: "nginx"
					}
					spec: containers: [
						{
							name:  "nginx"
							image: "nginx"
							ports: [{containerPort: 80}]
						},
					]
				}
			}
		}
	}
	Service: {
		"nginx": {
			apiVersion: "v1"
			metadata: {
				namespace: Namespace["example"].metadata.name
			}
			spec: {
				ports: [
					{
						port:       80
						targetPort: 80
					},
				]
				selector: Deployment["nginx"].spec.template.metadata.labels
			}
		}
	}
}
