package traefik

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

ingressroute:
	kubernetes.#ingressroute & {
		fqdn: "traefik.home.arpa"
		rules: [{
			match: "Host(`\(fqdn)`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))"
			services: [{
				name: "api@internal"
				kind: "TraefikService"
			}]
		}]
	}
