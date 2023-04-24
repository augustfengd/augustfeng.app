package pipeline

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:pipeline"
)

workflows: "apps.toolchain.yaml": {}

command: pipeline & {
	#workflows: workflows
}
