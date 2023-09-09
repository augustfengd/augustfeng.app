package syncthing

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

ingressroute:
	kubernetes.#ingressroute & {
		fqdn: "syncthing.home.arpa"
		rules: [{
			match: "Host(`\(fqdn)`)"
			services: [{
				name: "syncthing"
				port: 8384
			}]
		}]
	}

// wip
_ingressrouteudp: manifests: [{
	apiVersion: "traefik.io/v1alpha1"
	kind:       "IngressRouteUDP"
	metadata: name: "syncthing.home.arpa"
	spec: {
		entryPoints: [""]
		routes: [{
			services: [{
				name: "syncthing"
				port: 53
				// nativeLB: true
			}]
		}]
	}
}]
