package traefik

import (
	"path"
	"tool/http"
	"tool/exec"

	"github.com/augustfengd/augustfeng.app/cue.lib/tools:git"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:kubectl"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:secrets"
)

manifests: [
	crd.manifests,
	serviceaccount.manifests,
	clusterroles.manifests,
	clusterrolebinding.manifests,
	cm.manifests,
	deployment.manifests,
	ingressroute.manifests,
	middleware.manifests,
	basic_auth.manifests,
	monitoring.manifests,
]

command: secrets & {
	#secrets: path: "cloud/kubernetes/traefik/secrets"
}

command: kubectl & {
	#namespace: "system-ingress"
	#manifests: manifests
}

command: crd: {
	root: git.#root

	get: http.Get & {
		request: body: ""
		url: "https://raw.githubusercontent.com/traefik/traefik/v3.1.1/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml"
	}

	import: exec.Run & {
		outfile: path.FromSlash("cloud/kubernetes/traefik/crd.cue", "unix")
		stdin:   get.response.body
		cmd:     "cue import -f --list --path crd:manifests: -p traefik -o \(outfile) yaml: -"
		dir:     root.dir
	}
}
