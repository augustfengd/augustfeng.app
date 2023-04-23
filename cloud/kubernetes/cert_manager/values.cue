package cert_manager

values: {
	fullnameOverride: "cert-manager"
	serviceAccount: annotations: "iam.gke.io/gcp-service-account": "external-dns@augustfengd.iam.gserviceaccount.com"
}
