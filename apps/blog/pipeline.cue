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
		"build": {
			"runs-on": "ubuntu-latest"
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
			steps: [
				#actions.checkoutCode,
				#actions.make & {
					#target:             "all"
					"working-directory": "apps/blog"
				},
				#actions.artifact.upload & {
					with: {
						name: "blog"
						path: "/apps/blog/build/"
					}
				},
			]
		}
		"push": {
			"runs-on": "ubuntu-latest"
			needs: ["build"]
			steps: [
				#actions.checkoutCode,
				#actions.docker.login,
				#actions.artifact.download & {
					with: {
						name: "blog"
						path: "/apps/blog/build/"
					}
				},
				#actions.make & {
					#target:             "docker.push"
					"working-directory": "apps/blog"
				},
				#actions.make & {
					#target:             "digest.cue"
					"working-directory": "apps/blog"
				},
				#actions.artifact.upload & {
					with: {
						name: "digest"
						path: "/apps/blog/digest.cue"
					}
				},
			]
		}
		"apply": {
			"runs-on": "ubuntu-latest"
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
			needs: ["push"]
			steps: [
				#actions.checkoutCode,
				#actions.gcloud.auth,
				#actions.gcloud.install,
				#actions.gcloud.command & {
					#command: "components install gke-gcloud-auth-plugin"
				},
				#actions.artifact.download & {
					with: {
						name: "digest"
						path: "/apps/blog/digest.cue"
					}
				},
				#actions.cue.command & {
					#command: "apply"
					#package: "github.com/augustfengd/augustfeng.app/apps/blog"
				},
			]
		}
	}

}
