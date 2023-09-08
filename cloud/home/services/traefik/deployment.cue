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
			"/etc/traefik/traefik.yml": "traefik.yml"
		}
		sa: "traefik"
	} & {
		manifests: [
			{
				spec: template: spec: {
					containers: [{
						ports: [
							{
								name:          "web"
								containerPort: 80
								hostPort:      80
							},
							{
								name:          "dns"
								containerPort: 53
								hostPort:      53
							}]
					}]
				}
				// The running pod needs to let go of the host ports for the rollout to proceed.
				spec: strategy: type: "Recreate"
			},
			{}]
	}
