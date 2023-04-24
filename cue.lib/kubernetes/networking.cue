package kubernetes

import (
	networking "k8s.io/api/networking/v1"
)

#ingress: {
	host: string
	paths: [path=string]: {
		service: string
		port:    string
	}

	manifests: [ {
		networking.#Ingress & {
			metadata: name: host
			spec: rules: [{
				"host": host
				"http": "paths": [ for path, s in paths {
					"path":                    path
					"pathType":                "Prefix"
					"backend": service: {name: s.service, port: name: s.port}
				}]
			}]
		}
	}]
}
