package kubernetes

// this should imported from go code
traefik: #IngressRoute: {
	apiVersion: "traefik.containo.us/v1alpha1"
	kind:       "IngressRoute"
	metadata: {
		name:      string
		namespace: string
	}
	#rules: [...{
		match: string
		services: [...{
			name:  string
			port?: number | string
			kind:  *"Service" | "TraefikService"
		}]
	}]
	spec: routes: [ for r in #rules {match: r.match, services: r.services}]
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
		tls: {secretName?: string}
	}
}
