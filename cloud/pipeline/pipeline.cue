package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"github.com/augustfengd/augustfeng.app/cue.lib/pipeline"
)

workflows: "cloud.new.yaml": {
	#DefaultBranch: "main"

	name: "cloud'"
	on: push: branches:         #DefaultBranch
	on: pull_request: branches: #DefaultBranch
	on: [string]: paths: ["cloud/**", "cue.mod/**", "cue.lib/**"]

	concurrency: "augustfeng.app"

	let #actions = pipeline.#actions

	jobs: github.#Workflow.#Jobs & {
		"build": {
			"runs-on": "ubuntu-latest"
			steps: [
				#actions.checkoutCode,
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
		"configure": {
			name: "terraform cloud"
			needs: ["build"]
			"runs-on": "ubuntu-latest"
			steps: [
				#actions.checkoutCode,
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
		"terraform-plan": {
			name: "terraform (plan)"
			needs: ["build", "configure"]
			"runs-on": "ubuntu-latest"
			if:        "github.event_name == 'pull_request'"
			steps: [
				#actions.checkoutCode,
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
		"terraform-apply": {
			name: "terraform (apply)"
			needs: ["build", "configure"]
			"runs-on": "ubuntu-latest"
			if:        "github.event_name =='push'"
			steps: [
				#actions.checkoutCode,
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
		"cluster-services-apply": {
			name: "cluster services (apply)"
			needs: ["terraform-apply", "build"]
			"runs-on": "ubuntu-latest"
			env: {
				GOOGLE_CREDENTIALS:             "${{ secrets.GOOGLE_CREDENTIALS }}"
				GOOGLE_APPLICATION_CREDENTIALS: "application_default_credentials.json"
				KUBECONFIG:                     "kubeconfig.yaml"
			}
			if: "github.event_name =='push'"
			steps: [
				#actions.checkoutCode,
				#actions.with.decryptionKey & #actions.secrets.decrypt,
				#actions.with.decryptionKey & #actions.secrets.import,
				#actions.run & {
					run: "printf '%s' \"${GOOGLE_CREDENTIALS}\" > \"${GOOGLE_APPLICATION_CREDENTIALS}\""
				},
				#actions.run & {
					run: "cue apply github.com/augustfengd/augustfeng.app/cloud/kubernetes/traefik"
				},
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
		"cluster-services-diff": {
			name: "cluster services (diff)"
			needs: ["build"]
			"runs-on": "ubuntu-latest"
			env: {
				GOOGLE_CREDENTIALS:             "${{ secrets.GOOGLE_CREDENTIALS }}"
				GOOGLE_APPLICATION_CREDENTIALS: "application_default_credentials.json"
				KUBECONFIG:                     "kubeconfig.yaml"
			}
			if: "github.event_name == 'pull_request'"
			steps: [...{if: "env.GOOGLE_CREDENTIALS != ''"}]
			steps: [
				#actions.checkoutCode,
				#actions.with.decryptionKey & #actions.secrets.decrypt,
				#actions.with.decryptionKey & #actions.secrets.import,
				#actions.run & {
					run: "printf '%s' \"${GOOGLE_CREDENTIALS}\" > \"${GOOGLE_APPLICATION_CREDENTIALS}\""
				},
				#actions.run & {
					run: "cue diff github.com/augustfengd/augustfeng.app/cloud/kubernetes/traefik"
				},
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
	}
}
