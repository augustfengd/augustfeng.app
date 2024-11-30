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
		web: address:                   ":80"
		dns: address:                   "192.168.0.254:53/udp"
		"syncthing-tcp": address:       ":22000/tcp"
		"syncthing-udp": address:       ":22000/udp"
		"syncthing-discovery": address: ":21027/udp"
	}
	providers: kubernetesCRD: {}
}

cm: kubernetes.#configmaps & {
	"traefik": "traefik.yml": yaml.Marshal(traefik_yml)
}
