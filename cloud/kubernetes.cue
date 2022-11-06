package kubernetes

import (
	core "k8s.io/api/core/v1"
	apps "k8s.io/api/apps/v1"
	networking "k8s.io/api/networking/v1"
	argocd "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"
	traefik "github.com/traefik/traefik/v2/pkg/provider/kubernetes/crd/traefik/v1alpha1"
	certmanager "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

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
				name: _name
				labels: "app.kubernetes.io/name": _name
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
					name: _name
					labels: "app.kubernetes.io/name": _name
				}
				spec: ports: [ for n, p in expose.ports {name: n, port: p, targetPort: p, protocol: expose.protocol[n]}]
			}
		},
	]
	_manifest: _manifests[0]
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
	}] | *[core.#Secret]
	_manifest: _manifests[0]
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
	}] | *[core.#ConfigMap]
	_manifest: _manifests[0]
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
	_manifest: _manifests[0]
}

#ingressroute: {
	fqdn: string
	rules: [...{
		match: string
		services: [...{
			name:  string
			port?: number | string
			kind:  *"Service" | "TraefikService"
		}]
	}]

	_manifests: [traefik.#IngressRoute & {
		metadata: name:                        fqdn
		spec: routes: [ for r in rules {match: r.match, services: r.services}]
		spec: {
			entryPoints: ["websecure"]
			routes: [...{
				kind:  "Rule"
				match: string
				services: [...{
					name:  string
					port?: number | string
					kind:  string
				}]
			}]
			tls: {secretName: fqdn}
		}
	}]
	_manifest: _manifests[0]
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

		"cert-manager": argocd.#Application & {
			metadata: name: "cert-manager"
			spec: project:  "cloud"
			spec: source: {
				repoURL:        "https://github.com/augustfengd/augustfeng.app.git"
				path:           "."
				targetRevision: "main"
				plugin: {
					env: [
						{
							name:  "args"
							value: "export ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(components.\"cert-manager\".manifests)' --out text"
						},
				]
					name: "cue"
				}
			}
			spec: destination: namespace: "cert-manager"
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
			}
			logs: access: enabled: true
			providers: kubernetesIngress: publishedService: enabled: true
		}

		_application: argocd.#Application & {
			metadata: name: "traefik.chart"
			spec: project:  "cloud"
			spec: source: {
				repoURL:        "https://helm.traefik.io/traefik"
				targetRevision: "19.0.3"
				helm: values: yaml.Marshal(chartConfiguration)
				chart: "traefik"
			}
			spec: destination: namespace: "traefik"
		}

		_ingressroute: (#ingressroute & {
			fqdn: #fqdn
			rules: [{
				match: "Host(`\(fqdn)`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))"
				services: [{
					name: "api@internal"
					kind: "TraefikService"
				}]}]
		})._manifest

		manifests: [_application, _ingressroute]
	}
	"cert-manager": {
		#fqdn: string

		chartConfiguration: {
			serviceAccount: annotations: annotations: [string]: string
			fullnameOverride: "cert-manager"
		}

		_application: argocd.#Application & {
			metadata: name: "cert-manager.chart"

			spec: project: "cloud"
			spec: source: {
				repoURL:        "https://charts.jetstack.io"
				targetRevision: "1.10.0"
				helm: values: yaml.Marshal(chartConfiguration)
				chart: "cert-manager"
			}
			spec: destination: namespace: "cert-manager"
		}
		_clusterissuer: certmanager.#ClusterIssuer & {
			metadata: name: "letsencrypt"
			spec: acme: {
				email:  "augustfengd@gmail.com"
				server: "https://acme-v02.api.letsencrypt.org/directory"
				privateKeySecretRef: name: "letsencrypt-account-key"
				solvers: [{
					dns01: cloudDNS: project: "augustfengd"
				}]
			}
		}

		manifests: [_application, _clusterissuer]
	}
}
