package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
)

#DefaultBranch: "main"

name: "containers"
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
				let v = "v3.7.3"

				name: "Install sops"
				id:   "sops"
				run:  """
				mkdir -p bin/
				curl -L --output bin/sops https://github.com/mozilla/sops/releases/download/\(v)/sops-\(v).linux.amd64
				chmod +x bin/sops
				echo "${GITHUB_WORKSPACE}/bin" >> $GITHUB_PATH
				"""
			},
			{
				name: "Build and Publish Containers"
				uses: "dagger/dagger-for-github@v4"
				env: {
					GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"
				}
				with: {
					cmds: """
						do -p containers.cue push
						"""
					workdir: "containers"
				}
			},
		]
	}
}
