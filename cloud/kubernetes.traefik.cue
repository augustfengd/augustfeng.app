package kubernetes

import (
	argocd "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"
	certmanager "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

	"encoding/yaml"
)

"cloud-services": "traefik": {
	#fqdn: string

	chartConfiguration: {
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

	application: argocd.#Application & {
		metadata: name: "traefik.chart"
		spec: project:  "cloud"
		spec: source: {
			repoURL:        "https://helm.traefik.io/traefik"
			targetRevision: "19.0.3"
			helm: values: yaml.Marshal(chartConfiguration)
			chart: "traefik"
		}
		spec: destination: namespace: "traefik"
	}

	ingressroute: (#ingressroute & {
		fqdn: #fqdn
		rules: [{
			match: "Host(`\(fqdn)`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))"
			services: [{
				name: "api@internal"
				kind: "TraefikService"
			}]}]
	}).manifest

	certificate: (certmanager.#Certificate & {
		metadata: name: #fqdn
		spec: {
			dnsNames: [#fqdn]
			secretName: #fqdn
			issuerRef: {
				name: "letsencrypt"
				kind: "ClusterIssuer"
			}
		}
	})

	manifests: [application, ingressroute, certificate]
}
