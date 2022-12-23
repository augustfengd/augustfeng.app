package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"github.com/augustfengd/augustfeng.app/cloud:pipeline"
)

#DefaultBranch: "main"

name: "apps"
on: push: {
	branches: #DefaultBranch
	paths: ["apps/**"]
}

jobs: github.#Workflow.#Jobs & {
	let #actions = pipeline.#actions
	"blog": {
		"runs-on": "ubuntu-latest"
		_steps: [
			#actions.checkoutCode,
			#actions.run & {
				env: foobar: "${{ github.workspace }}"
				run: "echo ${foobar}; pwd"
			},
		]
		steps: [
			#actions.checkoutCode,
			#actions.run & {
				env: {
					GOOGLE_CREDENTIALS:             "${{ secrets.GOOGLE_CREDENTIALS }}"
					GOOGLE_APPLICATION_CREDENTIALS: "${{ github.workspace }}/apps/blog/application_default_credentials.json"
				}
				run:                 "printf '%s' \"${GOOGLE_CREDENTIALS}\" > \"${GOOGLE_APPLICATION_CREDENTIALS}\""
				"working-directory": "apps/blog"
			},
			#actions.install.sops,
			#actions.with.decryptionKey & {
				run:                 "mkdir -p ~/.docker; sops -d --output ~/.docker/config.json config.enc.json"
				"working-directory": "apps/blog"
			},
			{
				env: GOOGLE_APPLICATION_CREDENTIALS: "${{ github.workspace }}/apps/blog/application_default_credentials.json"
				name:                "build and deploy"
				run:                 "bazel run :deployment.apply"
				"working-directory": "apps/blog"
			},
		]
	}
}
