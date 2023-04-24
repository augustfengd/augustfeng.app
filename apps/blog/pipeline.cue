package blog

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"github.com/augustfengd/augustfeng.app/cue.lib/pipeline"
)

workflows: "apps.blog.yaml": {
	#DefaultBranch: "main"

	name: "apps/blog"

	on: push: {
		paths: ["apps/blog/**"]
		branches: #DefaultBranch
	}
	concurrency: "apps/blog"

	jobs: github.#Workflow.#Jobs & {
		let #actions = pipeline.#actions
		"build-push-apply": {
			"runs-on": "ubuntu-latest"
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
			steps: [
				#actions.checkoutCode,
				#actions.gcloud.auth,
				#actions.gcloud.install,
				#actions.docker.login,
				#actions.make & {
					#target:             "push"
					"working-directory": "apps/blog"
				},
				#actions.make & {
					#target:             "digest.cue"
					"working-directory": "apps/blog"
				},
				#actions.cue.command & {
					#command: "apply"
					#package: "github.com/augustfengd/augustfeng.app/apps/blog"
				},
			]
		}
	}

}
