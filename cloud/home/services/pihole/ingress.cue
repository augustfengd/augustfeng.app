package pihole

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

ingressroute:
	kubernetes.#ingressroute & {
		fqdn: "pihole.home.arpa"
		rules: [{
			match: "Host(`\(fqdn)`)"
			services: [{
				name: "pihole"
				port: 80
			}]
		}]
	}

ingressrouteudp: manifests: [{
	apiVersion: "traefik.io/v1alpha1"
	kind:       "IngressRouteUDP"
	metadata: name: "pihole.home.arpa"
	spec: {
		entryPoints: ["dns"]
		routes: [{
			services: [{
				name: "pihole"
				port: 53
				// nativeLB: true
			}]
		}]
	}
}]
