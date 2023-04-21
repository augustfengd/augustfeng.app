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
	// doing the same thing with promtool.
	promtool: kubernetes.#deployment & {
		name: "promtool"
		image: name: "prom/prometheus"
		expose: ports: http: 9090
		mount: emptydir: tsdb: "/prometheus": null
		manifests: [{
			spec: template: spec: initContainers: [{
				name:  "cue"
				image: "cuelang/cue"
				securityContext: runAsUser: 65534 // prometheus' uid
				volumeMounts: [{
					name: "tsdb", mountPath: "/tsdb"
				}]
			}, {
				name:  "cue"
				image: "cuelang/cue"
				securityContext: runAsUser: 65534 // prometheus' uid
				volumeMounts: [{
					name: "tsdb", mountPath: "/tsdb"
				}]
			}]
		}, ...]
		manifests: [...{metadata: namespace: "tsdb"}]
	}
}

manifests: _app.tsdb.manifests + _app.promtool.manifests
