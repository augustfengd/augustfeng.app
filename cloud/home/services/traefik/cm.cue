package traefik

import (
	"encoding/yaml"
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

#traefik_yml: {} // TODO: import schema from the go code

traefik_yml: {
	accessLog: {}
	log: level: "DEBUG"
	api: {
		dashboard: true
		insecure:  true
	}
	entryPoints: {
		web: address: ":80"
		dns: address: ":53/udp"
	}
	providers: kubernetesCRD: {}
}

cm: kubernetes.#configmaps & {
	"traefik": "traefik.yml": yaml.Marshal(traefik_yml)
}
