package kubernetes

import (
	core "k8s.io/api/core/v1"
	apps "k8s.io/api/apps/v1"
	networking "k8s.io/api/networking/v1"
	argocd "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"

	"strings"
	"encoding/base64"
	"encoding/yaml"
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
	"appofapps": {
		"traefik": argocd.#Application & {
			metadata: name: "traefik"
			spec: project:  "cloud"
			spec: source: {
				repoURL:        "https://github.com/augustfengd/augustfeng.app.git"
				path:           "."
				targetRevision: "main"
				plugin: {
					env: [
						{
							name:  "args"
							value: "export ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(components.traefik.manifests)' --out text"
						},
					]
					name: "cue"
				}
			}
			spec: destination: namespace: "traefik"
		}

		manifests: [components.appofapps.traefik]
	}
	"traefik": {
		#fqdn: string

		chartConfiguration: {
			fullnameOverride: "traefik"
			service: {
				enabled: true
				type:    "LoadBalancer"
				annotations: {
					"networking.gke.io/internal-load-balancer-allow-global-access": "true"
					"networking.gke.io/load-balancer-type":                         "Internal"
				}
			}
			logs: access: enabled: true
			providers: kubernetesIngress: publishedService: enabled: true
		}

		manifests: [ {
			argocd.#Application & {
				metadata: name: "traefik.chart"
				spec: project:  "cloud"
				spec: source: {
					repoURL:        "https://helm.traefik.io/traefik"
					targetRevision: "18.3.0"
					helm: values: yaml.Marshal(chartConfiguration)
					chart: "traefik"
				}
				spec: destination: namespace: "traefik"
			}
		},
			traefik.#IngressRoute & {
				metadata: name: "dashboard"
				#rules: [{
					match: "Host(`\(#fqdn)`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))"
					services: [{
						name: "api@internal"
						kind: "TraefikService"
					}]}]
				spec: tls: secretName: "traefik.augustfeng.app"
			}]
	}
}
