package traefik

import (
	"github.com/augustfengd/augustfeng.app/tools:kubectl"
)

manifests: [
	serviceaccount.manifests,
	clusterroles.manifests,
	clusterrolebinding.manifests,
	deployment.manifests,
]

kubectl & {
	#manifests: manifests
	#namespace: "system-ingress"
}
