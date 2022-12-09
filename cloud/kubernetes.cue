package kubernetes

import (
	core "k8s.io/api/core/v1"
	apps "k8s.io/api/apps/v1"
	networking "k8s.io/api/networking/v1"
	argocd "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"
	traefik "github.com/traefik/traefik/v2/pkg/provider/kubernetes/crd/traefik/v1alpha1"
	certmanager "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

	"struct"
	"strings"
	"list"
	"encoding/base64"
)

// NOTE: These definitions (#deployment, #secrets, #configmaps, ...) are
// abstracted interfaces that map to kubernetes object.

#deployment: {
	image: {
		name: string
		tag:  string | *"latest"
	}
	env: [string]: {// description: secret sources exclusively from secret or value.
			secret: null
			value:  string | *null
	} | {
		secret: struct.MaxFields(1) & struct.MinFields(1)
		secret: {
			// kubernetes object name
			[string]: {
				// secret key reference
				string
			}
		}
		value: null
	}
	args: [string]: null | string
	X=expose: ports: [string]: number
	expose: protocol: {for a, b in X.ports {(a): "UDP" | *"TCP"}} // NOTE: map each port to a protocol and provide an interface for override.
	mount: {
		secret: {}
		configmap: {}
		[=~"secret|configmap|emptydir|pvc"]: {
			// kubernetes object name
			[string]: {
				// mount path
				[string]: {
					// subpath
					string | *null
				}
			}
		}
	}

	let _name = { let s = strings.Split(image.name, "/"), s[len(s)-1]}
	manifests: {
		[
			apps.#Deployment & {
				X=metadata: {
					name: _name
					labels: "app.kubernetes.io/name": _name
				}
				spec: template: spec: containers: [{
					"image": image.name + ":" + image.tag
					"name":  _name
					"env": [ for k, v in _env_ {name: k, v}]
					_env_: {
						for n, c in env {
							if c.value != null {
								(n): value: c.value
							}
							if c.secret != null {
								(n): valueFrom: secretKeyRef: {
									for n, c in c.secret {
										name: n
										key:  c
									}
								}
							}
						}
					}
					"args": [ for k, v in args if v == null {k}] + list.FlattenN([ for k, v in args if v != null {[k, v]}], -1)
					"volumeMounts": [ for mp, c in _volumeMounts_ {mountPath: mp, c}]
					_volumeMounts_: {
						for s, c in {mount.secret, mount.configmap} {
							for mp, sp in c {
								(mp): {
									name: (s)
									if sp != null {
										subPath: (sp)
									}

								}
							}
						}
					}
				}]
				spec: template: spec: volumes:
					[ for s, _ in mount.secret {name: s, secret: secretName: s}] +
					[ for s, _ in mount.configmap {name: s, configMap: name: s}]
				spec: selector: matchLabels: X.labels
				spec: template: metadata: labels: X.labels
			},

			if len(expose.ports) > 0 {
				core.#Service & {
					metadata: {
						name: _name
						labels: "app.kubernetes.io/name": _name
					}
					spec: ports: [ for n, p in expose.ports {name: n, port: p, targetPort: p, protocol: expose.protocol[n]}]
				}
			},
		]
	}
}

#secrets: S={
	// kubernetes object name
	[!="manifests"]: {
		#type: core.#enumSecretType | *"Opaque"

		// key
		[k=string]: string
	}

	manifests: [ for n, d in S if n != "manifests" {
		core.#Secret & {
			metadata: name: n
			type: d.#type
			data: {for k, v in d {(k): base64.Decode(null, base64.Encode(null, v))}} // NOTE: convert string to base64 and then into bytes.
		}
	}]
}

#configmaps: S={
	// kubernetes object name
	[!="manifests"]: {
		// key
		[k=string]: string
	}

	manifests: [ for n, d in S if n != "manifests" {
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
	manifest: manifests[0]
}

#ingressroute: {
	fqdn: string
	rules: [...{
		match:       string
		middlewares: [string] | *[] // NOTE: only support zero or one for now; abstract later.
		services: [...{
			name:  string
			port?: number | string
			kind:  *"Service" | "TraefikService"
		}]
	}]
	middlewares: {
		[string]: stripPrefix: string // NOTE: only support stripPrefix for now; abstract later
	} | *null

	manifests: [traefik.#IngressRoute & {
		metadata: name: fqdn
		spec: routes: [ for r in rules {
			match:    r.match
			services: r.services
			middlewares: [ for middleware in r.middlewares {name: middleware}]
		}]
		spec: {
			entryPoints: ["websecure"]
			routes: [...{
				kind:  "Rule"
				match: string
				middlewares: [...{name: string}]
				services: [...{
					name:  string
					port?: number | string
					kind:  string
				}]
			}]
			tls: {secretName: fqdn}
		}
	}, ...]
	if middlewares != null {
		manifests: [traefik.#IngressRoute] + [ for n, spec in middlewares {
			apiVersion: "traefik.containo.us/v1alpha1"
			kind:       "Middleware"
			metadata: name: n
			"spec": stripPrefix: prefixes: [spec.stripPrefix]},
		]
	}
	manifest: manifests[0]
}

#certificate: {
	fqdn: string

	manifests: [certmanager.#Certificate & {
		metadata: name: fqdn
		spec: {
			dnsNames: [fqdn]
			secretName: fqdn
			issuerRef: {
				name: "letsencrypt"
				kind: "ClusterIssuer"
			}
		}
	}]
	manifest: manifests[0]
}

#application: {
	name:      string
	namespace: string

	manifests: [argocd.#Application & {
		metadata: "name": name
		spec: source: {
			repoURL:        string | *"https://github.com/augustfengd/augustfeng.app.git"
			path:           "."
			targetRevision: "main"
			plugin: {
				env: [
					{
						"name": "args"
						value:  "export ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(\"cluster-services\".\"\(name)\".manifests)' --out text"
					},
				]
				"name": "cue"
			}
		}
		spec: project: "cloud"
		spec: destination: "namespace": namespace
	}]
	manifest: manifests[0]
}
