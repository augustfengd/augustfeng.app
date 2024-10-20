package pihole

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:kubectl"
)

manifests: [
	namespace.manifests,
	cm.manifests,
	deployment.manifests,
	ingressroute.manifests,
	ingressrouteudp.manifests,
]

command: kubectl & {
	#namespace: "system-ingress"
	#manifests: manifests
}
