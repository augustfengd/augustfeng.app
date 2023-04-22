package pipeline

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:pipeline"
)

workflows: [string]: {}

pipeline & {
	#workflows: workflows
}
