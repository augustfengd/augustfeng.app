package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"github.com/augustfengd/augustfeng.app/cloud:pipeline"
)

#DefaultBranch: "main"

name: "apps/blog"
on: push: branches: #DefaultBranch

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
			#actions.make & {
				#target:             "apply"
				"working-directory": "apps/blog"
				env: {
					KUBECONFIG:                     "../../kubeconfig.yaml"
					GOOGLE_APPLICATION_CREDENTIALS: "../../application_default_credentials.json"
				}
			},
		]
	}
}
