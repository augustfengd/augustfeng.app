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
			steps: [
				#actions.checkoutCode,
				#actions.gcp.login & {
					env: {
						GOOGLE_CREDENTIALS:             "${{ secrets.GOOGLE_CREDENTIALS }}"
						GOOGLE_APPLICATION_CREDENTIALS: "application_default_credentials.json"
					}
				},
				#actions.docker.login,
				#actions.make & {
					#target:             "push"
					"working-directory": "apps/blog"
				},
				#actions.cue.command & {
					#command: "apply"
					#package: "github.com/augustfengd/augustfeng.app/apps/blog"

					env: {
						KUBECONFIG:                     "../../kubeconfig.yaml"
						GOOGLE_APPLICATION_CREDENTIALS: "../../application_default_credentials.json"
					}
				},
			]
		}
	}

}
