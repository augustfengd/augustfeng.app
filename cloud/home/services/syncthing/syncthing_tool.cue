package syncthing

import (
	"path"
	"tool/http"
	"tool/exec"

	"github.com/augustfengd/augustfeng.app/cue.lib/tools:git"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:kubectl"
)

manifests: [
	namespace.manifests,
	deployment.manifests,
	ingressroute.manifests,
	ingressroutetcp.manifests,
	ingressrouteudp.manifests,
]

command: kubectl & {
	#namespace: "syncthing"
	#manifests: manifests
}
