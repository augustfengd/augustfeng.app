package kubernetes

appofapps: {
	"traefik": #application & {
		name:      "traefik"
		namespace: "traefik"
		plugin: {
			name: "cue"
			args: "export ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(cluster_services.traefik.manifests)' --out text"
		}
	}

	"cert-manager": #application & {
		name:      "cert-manager"
		namespace: "cert-manager"
		plugin: {
			name: "cue"
			args: "export ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(cluster_services.\"cert-manager\".manifests)' --out text"
		}
	}

	"external-dns": #application & {
		name:      "external-dns"
		namespace: "external-dns"
		plugin: {
			name: "cue"
			args: "export ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(cluster_services.\"external-dns\".manifests)' --out text"
		}
	}

	manifests:
		appofapps."traefik".manifests +
		appofapps."cert-manager".manifests +
		appofapps."external-dns".manifests
}
