package prometheus

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

ingressroute: {
	_alertmanager: kubernetes.#ingressroute & {
		fqdn: "alertmanager.augustfeng.app"
		rules: [{
			match: "Host(`\(fqdn)`)"
			services: [{
				name: "alertmanager-operated"
				port: "web"
			}]
			middlewares: ["basic-auth"]
		}]
	}
	_prometheus:
		kubernetes.#ingressroute & {
			fqdn: "prometheus.augustfeng.app"
			rules: [{
				match: "Host(`\(fqdn)`)"
				services: [{
					name: "prometheus-operated"
					port: "web"
				}]
				middlewares: ["basic-auth"]}]
			}
	manifests: _alertmanager.manifests + _prometheus.manifests
}
