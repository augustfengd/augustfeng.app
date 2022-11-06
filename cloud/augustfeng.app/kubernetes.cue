package kubernetes

components: {
	"traefik": #fqdn: "traefik.augustfeng.app"
	"cert-manager": chartConfiguration: "iam.gke.io/gcp-service-account": "cert-manager@augustfengd.iam.gserviceaccount.com"
}
