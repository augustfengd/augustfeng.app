package domain

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"github.com/augustfengd/augustfeng.app/cue.lib/pipeline"
)

#DefaultBranch: "main"

name: "apps/domain"

on: push: {
	branches: #DefaultBranch
	paths: ["apps/domain/**"]
}

concurrency: "apps/domain"

jobs: github.#Workflow.#Jobs & {
	let #actions = pipeline.#actions
	"build-and-push": {
		"runs-on": "ubuntu-latest"
		steps: [
			#actions.checkoutCode,
			#actions.docker.login,
			#actions.skaffold.install,
			#actions.skaffold.command & {
				#command: "build"
				#flags: {
					"--file-output": "tags.json"
				}
				"working-directory": "apps/domain"
			},
			#actions.artifact.upload & {
				with: {
					name: "domain.k8s"
					path: "apps/domain/k8s"
				}
			},
			#actions.artifact.upload & {
				with: {
					name: "domain.tags"
					path: "apps/domain/tags.json"
				}
			},
		]
	}
	"deploy": {
		"runs-on": "ubuntu-latest"
		needs: ["build-and-push"]
		steps: [
			#actions.checkoutCode,
			#actions.skaffold.install,
			#actions.gcloud.auth,
			#actions.gcloud.install,
			#actions.gcloud.command & {
				#command: "components install gke-gcloud-auth-plugin"
			},
			#actions.gcloud.command & {
				#command: "container clusters get-credentials augustfeng-app"
				#flags: "--zone": "us-east1-b"
			},
			#actions.artifact.download & {
				with: {
					name: "domain.k8s"
					path: "apps/domain/k8s"
				}
			},
			#actions.artifact.download & {
				with: {
					name: "domain.tags"
					path: "apps/domain"
				}
			},
			#actions.skaffold.command & {
				#command: "deploy"
				#flags: "--build-artifacts": "tags.json"

				"working-directory": "apps/domain"
			},
		]
	}
}
