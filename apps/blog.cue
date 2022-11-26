package apps

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
		expose: ports: http: 1313
	}
	manifests:
		[namespace] +
		deployment.manifests
}
