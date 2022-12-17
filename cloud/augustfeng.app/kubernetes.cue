package kubernetes

cluster_services: {
	"traefik": #fqdn: "traefik.augustfeng.app"
	"cert-manager": chart: helm: values: serviceAccount: annotations: "iam.gke.io/gcp-service-account": "cert-manager@augustfengd.iam.gserviceaccount.com"
	"external-dns": chart: helm: values: annotations: "iam.gke.io/gcp-service-account": "external-dns@augustfengd.iam.gserviceaccount.com"
}
