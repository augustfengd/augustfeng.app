package blog

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:kubectl"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:pipeline"
)

manifests: [
	deployment.manifests,
	ingressroute.manifests
]

workflows: [string]: {}

command: kubectl & {
	#namespace: "blog"
	#manifests: manifests
}

command: "pipeline": {
	let p = pipeline & {
		#workflows: workflows
	}
	p.build
}
