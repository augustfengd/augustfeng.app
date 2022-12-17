package kubernetes

cluster_services: "traefik": {
	#fqdn: string

	chart: #application & {
		name:      "traefik.chart"
		namespace: "traefik"
		helm: {
			url:      "https://helm.traefik.io/traefik"
			revision: "19.0.3"
			values: {
				fullnameOverride: "traefik"
				nodeSelector: "cloud.google.com/gke-nodepool": "default-pool"
				{
					ports: web: hostPort:       80
					ports: websecure: hostPort: 443
					service: enabled: false
				}
				logs: access: enabled: true
				providers: kubernetesIngress: publishedService: enabled: true
			}
			chart: "traefik"
		}
	}

	ingressroute: #ingressroute & {
		fqdn: #fqdn
		rules: [{
			match: "Host(`\(fqdn)`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))"
			services: [{
				name: "api@internal"
				kind: "TraefikService"
			}]}]
	}

	certificate: #certificate & {
		fqdn: #fqdn
	}

	manifests:
		chart.manifests +
		ingressroute.manifests +
		certificate.manifests
}
