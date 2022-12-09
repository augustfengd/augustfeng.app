package kubernetes

import (
	argocd "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"
	certmanager "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

	"encoding/yaml"
)

"cloud-services": "cert-manager": {
	chartConfiguration: {
		serviceAccount: annotations: [string]: string
		fullnameOverride: "cert-manager"
		installCRDs:      true
	}

	application: argocd.#Application & {
		metadata: name: "cert-manager.chart"

		spec: project: "cloud"
		spec: source: {
			repoURL:        "https://charts.jetstack.io"
			targetRevision: "1.10.0"
			helm: values: yaml.Marshal(chartConfiguration)
			chart: "cert-manager"
		}
		spec: destination: namespace: "cert-manager"
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

	manifests: [application, clusterissuer]
}
