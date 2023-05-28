package traefik

import (
	"encoding/yaml"
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

#traefik_yml: {

}

traefik_yml: {
	log: level: "INFO"
	api: {
		dashboard: true
		insecure:  true
	}
	providers: kubernetesCRD: {}
	certificateResolvers: letsencrypt: acme: {
		email:   "augustfengd@gmail.com"
		storage: "acme.json"
		tlsChallenge: {}
		caserver: "https://acme-staging-v02.api.letsencrypt.org/directory"
	}
}

cm: kubernetes.#configmaps & {
	"traefik": "traefik.yml": yaml.Marshal(traefik_yml)
}
