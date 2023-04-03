package kubernetes

import (
	"github.com/augustfengd/augustfeng.app/cloud:kubernetes"
)

_app: {
	sleep: {kubernetes.#pod & {image: name: "augustfengd/augustfeng.app/sleep"}}
}

manifests: _app.sleep.manifests
