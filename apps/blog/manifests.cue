package blog

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

deployment:
	kubernetes.#deployment & {
		image: {
			name:   "ghcr.io/augustfengd/augustfeng.app/blog"
		}
		expose: ports: http: 80
	}

ingressroute:
	kubernetes.#ingressroute & {
		fqdn: "blog.augustfeng.app"
		rules: [{
			match: "Host(`\(fqdn)`)"
			services: [{
				name: "blog"
				port: 80
			}]}]
	}

certificate:
	kubernetes.#certificate & {
		fqdn: "blog.augustfeng.app"
	}
