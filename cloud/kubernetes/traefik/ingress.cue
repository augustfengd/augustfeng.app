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
			}]}]
	}

certificate:
	kubernetes.#certificate & {
		fqdn: "traefik.augustfeng.app"
	}
