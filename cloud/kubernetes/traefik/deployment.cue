package traefik

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

deployment:
	kubernetes.#deployment & {
		image: name: "traefik"
		expose: ports: "web":       80
		expose: ports: "dashboard": 8080
		mount: configmap: "traefik": {
			#data:                      "foobar"
			"/etc/traefik/traefik.yml": "traefik.yml"
		}
		sa: "traefik"
	} & {
		manifests: [
			{
				spec: template: spec: {
					containers: [{
						ports: [{
							name:          "websecure"
							containerPort: 443
							hostPort:      443
						}]
					}]
					nodeSelector: "cloud.google.com/gke-nodepool": "default-pool"
				}
			}, {}]
	}
