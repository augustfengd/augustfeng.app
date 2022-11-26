package apps

import (
	"github.com/augustfengd/augustfeng.app/cloud:kubernetes"
)

blog: {
	deployment: kubernetes.#deployment & {
		image: name: "ghcr.io/augustfengd/augustfeng.app/blog"
		expose: ports: http: 1313
	}

	manifests: deployment.manifests
}
