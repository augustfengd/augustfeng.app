package traefik

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

deployment:
	kubernetes.#deployment & {
		image: name: "traefik"
		args: {
			"--api.insecure":                null
			"--providers.kubernetesingress": null
		}
		expose: ports: "web":       80
		expose: ports: "dashboard": 8080
		sa: "traefik"
	}
