package traefik

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

ingressroute:
	kubernetes.#ingressroute & {
		fqdn: "traefik.augustfeng.app"
		rules: [{
			match: "Host(`\(fqdn)`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))"
			services: [{
				name: "api@internal"
				kind: "TraefikService"
			}]
			middlewares: ["basic-auth"]
		}]
	}

middleware: manifests: [{
	apiVersion: "traefik.io/v1alpha1"
	kind:       "Middleware"
	metadata: name: "basic-auth"
	spec: basicAuth: secret: "basic-auth"
}]
