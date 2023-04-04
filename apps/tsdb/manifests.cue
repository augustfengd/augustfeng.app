package kubernetes

import (
	"github.com/augustfengd/augustfeng.app/cloud:kubernetes"
)

_app: {
	tsdb: {kubernetes.#pod & {image: name: "prom/prometheus"}}
	tsdb: manifests: [{
		spec: containers: [{
			volumeMounts: [{
				name: "tsdb", mountPath: "/tsdb"
			}]
		}]
		spec: initContainers: [{
			name:  "tsdb"
			image: "ghcr.io/augustfengd/augustfeng.app/tsdb"
			volumeMounts: [{
				name: "tsdb", mountPath: "/tsdb"
			}]
		}]
		spec: volumes: [{
			name: "tsdb"
			emptyDir: {}
		}]
	}]
}

manifests: _app.tsdb.manifests
