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
