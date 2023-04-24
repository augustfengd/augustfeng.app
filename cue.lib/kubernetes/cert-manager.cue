package kubernetes

import (
	certmanager "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
)

#certificate: {
	fqdn: string

	manifests: [certmanager.#Certificate & {
		metadata: name: fqdn
		spec: {
			dnsNames: [fqdn]
			secretName: fqdn
			issuerRef: {
				name: "letsencrypt"
				kind: "ClusterIssuer"
			}
		}
	}]
}

#clusterissuer: {
	manifests: [certmanager.#ClusterIssuer & {
		metadata: name: "letsencrypt"
		spec: acme: {
			email:  "augustfengd@gmail.com"
			server: "https://acme-v02.api.letsencrypt.org/directory"
			privateKeySecretRef: name: "letsencrypt-account-key"
			solvers: [{
				dns01: cloudDNS: project: "augustfengd"
			}]
		}
	}]
}
