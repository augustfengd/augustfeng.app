package blog

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:kubectl"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:pipeline"
)

manifests: [
	deployment.manifests,
	ingressroute.manifests,
	certificate.manifests,
]

workflows: "blog.yaml": {}

k: kubectl & {
	#namespace: "blog"
	#manifests: manifests
}

p: pipeline & {
	#workflows: workflows
}

command: pipeline: p.command.build
command: {
	template: k.command.template
	diff:     k.command.diff
	apply:    k.command.apply
}
