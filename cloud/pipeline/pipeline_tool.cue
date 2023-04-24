package pipeline

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:pipeline"
)

workflows: [string]: {}

command: pipeline & {
	#workflows: workflows
}
