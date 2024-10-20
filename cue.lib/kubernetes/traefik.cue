package kubernetes

import (
	ingressroute "traefik.io/ingressroute/v1alpha1"
)

traefik: {
	#IngressRoute: ingressroute.#IngressRoute
}

#ingressroute: {
	fqdn: string
	rules: [...{
		match:       string
		middlewares: [...string] | *[] // NOTE: only support zero or one for now; abstract later.
		services: [...{
			name:  string
			port?: string // int's don't work with the generated traefik cue files.
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
			spec: entryPoints: ["web"]
		}
		spec: {
			entryPoints: ["web"]
		} | *{
			entryPoints: ["websecure"]
			tls: certResolver: "letsencrypt"
		}
	}]
}
