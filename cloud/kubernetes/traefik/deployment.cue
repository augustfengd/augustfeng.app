package traefik

import (
	"crypto/md5"
	"encoding/yaml"
	"encoding/base64"

	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

traefik_yml: {}

deployment:
	kubernetes.#deployment & {
		image: name:       "traefik"
		annotations: hash: base64.Encode(null, md5.Sum(yaml.Marshal(traefik_yml)))
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
