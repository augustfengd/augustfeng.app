package blog

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"github.com/augustfengd/augustfeng.app/cue.lib/pipeline"
)

workflows: "apps.blog.yaml": {
	#DefaultBranch: "main"

	name: "apps/blog"

	on: push: {
		branches: #DefaultBranch
		paths: ["apps/blog/**"]
	}
	concurrency: "apps/blog"

	jobs: github.#Workflow.#Jobs & {
		let #actions = pipeline.#actions
		"lint": {
			"runs-on": "ubuntu-latest"
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
			steps: [
				#actions.checkoutCode,
				#actions.just.install,
				#actions.just.run & {
					#recipe:             "lint"
					"working-directory": "apps/blog"
				},
			]
		}
		"build": {
			"runs-on": "ubuntu-latest"
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
			needs: ["lint"]
			steps: [
				#actions.checkoutCode,
				#actions.make & {
					#target:             "all"
					"working-directory": "apps/blog"
				},
				#actions.artifact.upload & {
					with: {
						name: "blog"
						path: "apps/blog/build/"
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
						path: "apps/blog/build/"
					}
				},
				#actions.make & {
					#target:             "docker.push"
					"working-directory": "apps/blog"
				},
				#actions.make & {
					#target:             "docker.pull"
					"working-directory": "apps/blog"
				},
				{
					name: "make digest.cue"
					uses: "docker://ghcr.io/augustfengd/augustfeng.app/toolchain"
					with: args: "make -C apps/blog digest.cue"
				},
				#actions.artifact.upload & {
					with: {
						name: "digest"
						path: "apps/blog/digest.cue"
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
				#actions.gcloud.command & {
					#command: "container clusters get-credentials augustfeng-app"
					#flags: "--zone": "us-east1-b"
				},
				#actions.artifact.download & {
					with: {
						name: "digest"
						path: "apps/blog"
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
