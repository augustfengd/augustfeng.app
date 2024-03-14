package prometheus

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

deployment: kubernetes.#deployment & {
	image: {
		name: "quay.io/prometheus-operator/prometheus-operator"
		tag:  "v0.72.0"
	}
	expose: ports: "http": 8080
	args: "kubelet-service":            "kube-system/kubelet"
	args: "prometheus-config-reloader": "quay.io/prometheus-operator/prometheus-config-reloader:v0.72.0"
}
