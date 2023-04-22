package cert_manager

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:helm"
)

values: {}
manifests: [
	clusterissuer.manifests,
]

helm & {
	#namespace: "system-ingress"
	#name:      "foobar"
	#chart:     "jetstack/cert-manager"
	#values:    values
}
