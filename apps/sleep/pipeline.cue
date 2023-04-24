package sleep

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"github.com/augustfengd/augustfeng.app/cue.lib/pipeline"
)

workflow: "apps.sleep.yaml": {
	#DefaultBranch: "main"

	name: "apps/sleep"

	on: push: {
		paths: ["apps/sleep/**"]
		branches: #DefaultBranch
	}

	concurrency: "apps/sleep"

	jobs: github.#Workflow.#Jobs & {
		let #actions = pipeline.#actions
		"build-and-push": {
			"runs-on": "ubuntu-latest"
			steps: [
				#actions.checkoutCode,
				#actions.install.skaffold,
				#actions.docker.login,
				#actions.run & {
					run:                 "skaffold build --push"
					"working-directory": "apps/sleep"
				},
			]
		}
	}
}
