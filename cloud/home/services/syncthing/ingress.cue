package syncthing

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

ingressroute:
	kubernetes.#ingressroute & {
		fqdn: "syncthing.home.arpa"
		rules: [{
			match: "Host(`\(fqdn)`) || Host(`syncthing`)"
			services: [{
				name: "syncthing"
				port: 8384
			}]
		}]
	}

ingressroutetcp: manifests: [{
	apiVersion: "traefik.io/v1alpha1"
	kind:       "IngressRouteTCP"
	metadata: name: "tcp.syncthing.home.arpa"
	spec: {
		entryPoints: ["syncthing-tcp"]
		routes: [{
			match: "HostSNI(`*`)"
			services: [{
				name: "syncthing"
				port: 22000
			}]
		}]
	}
}]

ingressrouteudp: manifests: [{
	apiVersion: "traefik.io/v1alpha1"
	kind:       "IngressRouteUDP"
	metadata: name: "udp.syncthing.home.arpa"
	spec: {
		entryPoints: ["syncthing-udp"]
		routes: [{
			services: [{
				name: "syncthing"
				port: 22000
			}]
		}]
	}
}, {
	apiVersion: "traefik.io/v1alpha1"
	kind:       "IngressRouteUDP"
	metadata: name: "discovery.syncthing.home.arpa"
	spec: {
		entryPoints: ["syncthing-discovery"]
		routes: [{
			services: [{
				name: "syncthing"
				port: 21027
			}]
		}]
	}
},
]
