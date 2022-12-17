package kubernetes

cluster_services: "external-dns": {

	chart: #application & {
		name:      "external-dns.chart"
		namespace: "external-dns"
		helm: {
			url:      "https://kubernetes-sigs.github.io/external-dns/"
			revision: "1.11.0"
			values: {
				serviceAccount: annotations: [string]: string
				policy:           "sync"
				fullnameOverride: "external-dns"
				provider:         "google"
			}
			chart: "external-dns"
		}
	}

	manifests:
		chart.manifests
}
