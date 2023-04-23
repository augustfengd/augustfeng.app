package pipeline

import (
	"tool/file"
	"encoding/yaml"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:git"
)

#workflows: [string]: {}

command: build: {
	root: git.#root
	for f, pipeline in #workflows {
		(f): file.Create & {
			filename: root.dir + "/.github/workflows/" + f
			contents: yaml.Marshal(pipeline)
		}
	}
}

command: clean: {
	root: git.#root
	for f, pipeline in #workflows {
		(f): file.RemoveAll & {
			path: root.dir + "/.github/workflows/" + f
		}
	}
}
