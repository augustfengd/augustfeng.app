package kubernetes

appofapps: {
	"traefik": #application & {
		name:      "traefik"
		namespace: "traefik"
	}

	"cert-manager": #application & {
		name:      "cert-manager"
		namespace: "cert-manager"
	}

	"external-dns": #application & {
		name:      "external-dns"
		namespace: "external-dns"
	}

	manifests: [appofapps."traefik".manifest, appofapps."cert-manager".manifest, appofapps."external-dns".manifest]
}
