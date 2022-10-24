package kubernetes

import (
	core "k8s.io/api/core/v1"
	apps "k8s.io/api/apps/v1"
	networking "k8s.io/api/networking/v1"
	"strings"
	"encoding/base64"
)

// NOTE: These definitions (#deployment, #secrets, #configmaps, ...) are
// abstracted interfaces that map to kubernetes object.

#deployment: {
	image: {
		name: string
		tag:  string
	}
	args: [...string]
	X=expose: ports: [string]: number
	expose: protocol: {for a, b in X.ports {(a): "UDP" | *"TCP"}} // NOTE: map each port to a protocol and provide an interface for override.

	_name: { let s = strings.Split(image.name, "/"), s[len(s)-1]}
	_manifests: [
		apps.#Deployment & {
			X=metadata: {
				"name": _name
				labels: {
					"app.kubernetes.io/name": _name
				}
			}
			spec: template: spec: containers: [{
				"image": image.name + ":" + image.tag
				"name":  _name
				"args":  args
			}]
			spec: selector: matchLabels: X.labels
			spec: template: metadata: labels: X.labels
		},

		if len(expose.ports) > 0 {
			core.#Service & {
				metadata: {
					"name": _name
					labels: {
						"app.kubernetes.io/name": _name
					}
				}
				spec: ports: [ for n, p in expose.ports {name: n, port: p, targetPort: p, protocol: expose.protocol[n]}]
			}
		},
	]
}

#secrets: S={
	[sec=string]: {
		[k=string]: string
	}

	_manifests: [ for n, d in S {
		core.#Secret & {
			metadata: name: n
			data: {for k, v in d {(k): base64.Decode(null, base64.Encode(null, v))}} // NOTE: convert string to base64 and then into bytes.
		}
	}]
}

#configmaps: S={
	[cm=string]: {
		[k=string]: string
	}

	_manifests: [ for n, d in S {
		core.#ConfigMap & {
			metadata: name: n
			data: {for k, v in d {(k): v}}
		}
	}]
}

#ingress: {
	host: string
	paths: [path=string]: {
		service: string
		port:    string
	}

	_manifests: [ {
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

components: {
	nginx: #deployment
}

manifests: components.nginx._manifests
