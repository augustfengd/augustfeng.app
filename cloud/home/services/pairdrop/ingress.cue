package pairdrop

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

ingressroute:
	kubernetes.#ingressroute & {
		fqdn: "pairdrop.home.arpa"
		rules: [{
			match: "Host(`\(fqdn)`)"
			services: [{
				name: "pairdrop"
				port: 3000
			}]
		}]
	}
