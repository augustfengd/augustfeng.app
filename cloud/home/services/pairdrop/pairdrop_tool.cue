package pairdrop

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
]

command: kubectl & {
	#namespace: "pairdrop"
	#manifests: manifests
}
