package kubernetes

import (
	certmanager "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
)

cluster_services: "cert-manager": {
	chartConfiguration: {
		serviceAccount: annotations: [string]: string
		fullnameOverride: "cert-manager"
		installCRDs:      true
	}

	chart: #application & {
		name:      "cert-manager.chart"
		namespace: "cert-manager"
		helm: {
			url:      "https://charts.jetstack.io"
			revision: "1.10.0"
			values: {
				serviceAccount: annotations: [string]: string
				fullnameOverride: "cert-manager"
				installCRDs:      true
			}
			chart: "cert-manager"
		}
	}

	clusterissuer: certmanager.#ClusterIssuer & {
		metadata: name: "letsencrypt"
		spec: acme: {
			email:  "augustfengd@gmail.com"
			server: "https://acme-v02.api.letsencrypt.org/directory"
			privateKeySecretRef: name: "letsencrypt-account-key"
			solvers: [{
				dns01: cloudDNS: project: "augustfengd"
			}]
		}
	}

	manifests:
		chart.manifests +
		[clusterissuer]
}
