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

jobs: github.#Workflow.#jobs & {
	"build": {
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
				name: "Publish containers"
				uses: "dagger/dagger-for-github@v3"
				env: {
					SOPS_AGE_KEY: "${{ secrets.SOPS_AGE_KEY }}"
				}
				with: {
					version: "v0.2.36"
					cmds: """
						do -p containers.cue push
						"""
					workdir: "containers"
				}
			},
		]
	}
}
