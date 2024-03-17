package kubernetes

import (
	traefik "github.com/traefik/traefik/v2/pkg/provider/kubernetes/crd/traefikio/v1alpha1"
)

#ingressroute: {
	fqdn: string
	rules: [...{
		match:       string
		middlewares: [...string] | *[] // NOTE: only support zero or one for now; abstract later.
		services: [...{
			name:  string
			port?: number | string
			kind:  *"Service" | "TraefikService"
		}]
	}]

	manifests: [traefik.#IngressRoute & {
		metadata: name: fqdn
		spec: routes: [ for r in rules {
			kind:     "Rule"
			match:    r.match
			services: r.services
			middlewares: [ for middleware in r.middlewares {name: middleware, namespace: string | *"system-ingress"}]
		}]

		if fqdn =~ ".home.arpa" {
			spec: entrypoints: ["web"]
		}
		spec: {
			entryPoints: ["web"]
		} | *{
			entryPoints: ["websecure"]
			tls: certResolver: "letsencrypt"
		}
	}]
}
