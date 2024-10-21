package pairdrop

import (
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
