package kubernetes

import (
	argocd "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"

	"encoding/yaml"
)

"cloud-services": "external-dns": {
	chartConfiguration: {
		serviceAccount: annotations: [string]: string
		policy:           "sync"
		fullnameOverride: "external-dns"
		provider:         "google"
	}

	application: argocd.#Application & {
		metadata: name: "external-dns.chart"

		spec: project: "cloud"
		spec: source: {
			repoURL:        "https://kubernetes-sigs.github.io/external-dns/"
			targetRevision: "1.11.0"
			helm: values: yaml.Marshal(chartConfiguration)
			chart: "external-dns"
		}
		spec: destination: namespace: "external-dns"
	}

	manifests: [application]
}
