package kubernetes

components: {
	"traefik": #fqdn: "traefik.augustfeng.app"

	"cert-manager": chartConfiguration: serviceAccount: annotations: "iam.gke.io/gcp-service-account": "cert-manager@augustfengd.iam.gserviceaccount.com"

	"external-dns": chartConfiguration: serviceAccount: annotations: "iam.gke.io/gcp-service-account": "external-dns@augustfengd.iam.gserviceaccount.com"
}
