package prometheus

import (
	"path"
	"tool/http"
	"tool/exec"

	"github.com/augustfengd/augustfeng.app/cue.lib/tools:git"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:secrets"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:kubectl"
)

manifests: [
	crd.manifests,
	prometheus_operator.clusterroles.manifests,
	prometheus_operator.serviceaccount.manifests,
	prometheus_operator.clusterrolebinding.manifests,
	prometheus_operator.deployment.manifests,
	prometheus.clusterroles.manifests,
	prometheus.serviceaccount.manifests,
	prometheus.clusterrolebinding.manifests,
	prometheus.manifests,
	alertmanagerconfig.manifests,
	alertmanager.manifests,
]

command: secrets & {
	#secrets: path: "cloud/kubernetes/prometheus/secrets"
}

command: kubectl & {
	#namespace: "system-monitoring"
	#manifests: manifests
}

command: crd: {
	root: git.#root

	get: http.Get & {
		request: body: ""
		url: "https://github.com/prometheus-operator/prometheus-operator/releases/download/v0.72.0/stripped-down-crds.yaml"
	}

	import: exec.Run & {
		outfile: path.FromSlash("cloud/kubernetes/prometheus/crd.cue", "unix")
		stdin:   get.response.body
		cmd:     "cue import -f --list --path crd:manifests: -p prometheus -o \(outfile) yaml: -"
		dir:     root.dir
	}
}
