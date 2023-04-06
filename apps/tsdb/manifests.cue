package kubernetes

import (
	"github.com/augustfengd/augustfeng.app/cloud:kubernetes"
)

_app: {
	tsdb: kubernetes.#deployment & {
		image: name: "prom/prometheus"
		expose: ports: http: 9090
		mount: emptydir: tsdb: "/prometheus": null
		manifests: [{
			spec: template: spec: initContainers: [{
				name:  "tsdb"
				image: "ghcr.io/augustfengd/augustfeng.app/tsdb"
				securityContext: runAsUser: 65534 // prometheus' uid
				volumeMounts: [{
					name: "tsdb", mountPath: "/tsdb"
				}]
			}]
		}, ...]
		manifests: [...{metadata: namespace: "tsdb"}]
	}
}

manifests: _app.tsdb.manifests
