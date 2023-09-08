package kubernetes

import (
	traefik "github.com/traefik/traefik/v2/pkg/provider/kubernetes/crd/traefikio/v1alpha1"
)

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

		}
		if fqdn =~ ".home.arpa" {
			spec: entryPoints: ["web"]
		}
		spec: {
			entryPoints: ["web"]
		} | *{
			entryPoints: ["websecure"]
			tls: certResolver: "letsencrypt"
		}
	}]
	// fix me when I'm less lazy
	fixme: {
		if middlewares != null {
			[ for n, spec in middlewares {
				apiVersion: "traefik.io/v1alpha1"
				kind:       "Middleware"
				metadata: name: n
				"spec": stripPrefix: prefixes: [spec.stripPrefix]},
			]
		}
	}
}
