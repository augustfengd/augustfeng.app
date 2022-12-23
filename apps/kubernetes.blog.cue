package kubernetes

import (
	"github.com/augustfengd/augustfeng.app/cloud:kubernetes"
	core "k8s.io/api/core/v1"
)

blog: {
	namespace: core.#Namespace & {
		metadata: name: "apps-blog"
	}

	deployment: kubernetes.#deployment & {
		image: name: "ghcr.io/augustfengd/augustfeng.app/blog"
		expose: ports: http: 80
	}
	ingressroute: kubernetes.#ingressroute & {
		fqdn: "blog.augustfeng.app"
		rules: [{
			match: "Host(`\(fqdn)`)"
			services: [{
				name: "blog"
				port: 80
			}]}]
	}
	certificate: kubernetes.#certificate & {
		fqdn: "blog.augustfeng.app"
	}

	manifests:
		[namespace] +
		deployment.manifests +
		ingressroute.manifests +
		certificate.manifests
}
