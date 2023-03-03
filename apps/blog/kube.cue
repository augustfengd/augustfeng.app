package kubernetes

import (
	"github.com/augustfengd/augustfeng.app/cloud:kubernetes"
	core "k8s.io/api/core/v1"
	"strings"
)

_image: [
	{
		RepoDigests: [string]
	},
]

_app: {
	namespace: core.#Namespace & {
		metadata: name: "apps-blog"
	}
	deployment: kubernetes.#deployment & {
		image: {
			name:   string | *strings.Split(_image[0].RepoDigests[0], "@")[0]
			digest: string | *strings.Split(_image[0].RepoDigests[0], "@")[1]
		}
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
}

manifests:
	[_app.namespace] +
	_app.deployment.manifests +
	_app.ingressroute.manifests +
	_app.certificate.manifests
