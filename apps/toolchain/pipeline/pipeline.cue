package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
)

workflows: "apps.toolchain.yaml": {
	#DefaultBranch: "main"
	name:           "apps/toolchain"
	on: push: {
		branches: #DefaultBranch
		paths: ["containers/**"]
	}

	jobs: github.#Workflow.#Jobs & {
		"build-and-push": {
			"runs-on": "ubuntu-latest"
			steps: [
				{
					name: "Checkout code"
					uses: "actions/checkout@v3"
				},
				{
					name: "Build and Publish Toolchain Image"
					uses: "dagger/dagger-for-github@v4"
					env: GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"
					with: {
						cmds: """
						do push
						"""
						workdir: "apps/toolchain"
					}
				},
			]
		}
	}
}
