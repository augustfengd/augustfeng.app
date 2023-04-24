package sleep

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:pipeline"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:git"

	"tool/file"
	"encoding/yaml"
)

manifests: sleep.manifests

workflows: [string]: {}

command: "build.manifests": {
	root:  git.#root
	mkdir: file.Mkdir & {
		path: root.dir + "/apps/sleep/k8s"
	}
	f: file.Create & {
		filename: mkdir.path + "/manifests.yaml"
		contents: yaml.MarshalStream(manifests)
	}
}

command: "pipeline": {
	let p = pipeline & {
		#workflows: workflows
	}
	p.build
}
