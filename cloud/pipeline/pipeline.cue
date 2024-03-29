package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"github.com/augustfengd/augustfeng.app/cue.lib/pipeline"
)

workflows: "cloud.yaml": {
	#DefaultBranch: "main"

	name: "cloud"
	on: push: branches: #DefaultBranch
	on: [string]: paths: ["cloud/**", "cue.mod/**", "cue.lib/**"]

	concurrency: "augustfeng.app"

	let #actions = pipeline.#actions

	jobs: github.#Workflow.#Jobs & {
		"configure": {
			name:      "configure"
			"runs-on": "ubuntu-latest"
			steps: [
				#actions.checkoutCode,
				#actions.with.decryptionKey & #actions.secrets.decrypt,
				#actions.secrets.import,
				#actions.cue.command & {
					#command: "configure"
					#package: "github.com/augustfengd/augustfeng.app/cloud/terraform:augustfeng_app"
				},
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
		"terraform": {
			name: "terraform apply"
			needs: ["configure"]
			"runs-on": "ubuntu-latest"
			if:        "github.event_name =='push'"
			steps: [
				#actions.checkoutCode,
				#actions.with.decryptionKey & #actions.secrets.decrypt,
				#actions.secrets.import,
				#actions.cue.command & {
					#command: "build"
					#package: "github.com/augustfengd/augustfeng.app/cloud/terraform:augustfeng_app"
				},
				#actions.cue.command & {
					#command: "init"
					#package: "github.com/augustfengd/augustfeng.app/cloud/terraform:augustfeng_app"
				},
				#actions.cue.command & {
					#command: "apply"
					#package: "github.com/augustfengd/augustfeng.app/cloud/terraform:augustfeng_app"
				},
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
		"traefik": {
			name: "traefik"
			needs: ["terraform"]
			"runs-on": "ubuntu-latest"
			if:        "github.event_name =='push'"
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
				#actions.with.decryptionKey & #actions.secrets.decrypt,
				#actions.secrets.import,
				#actions.with.decryptionKey & #actions.secrets.decrypt & {
					#package: "github.com/augustfengd/augustfeng.app/cloud/kubernetes/traefik"
				},
				#actions.secrets.import & {
					#package: "github.com/augustfengd/augustfeng.app/cloud/kubernetes/traefik"
				},
				#actions.cue.command & {
					#command: "apply"
					#package: "github.com/augustfengd/augustfeng.app/cloud/kubernetes/traefik"
				},
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
		"prometheus": {
			name: "prometheus"
			needs: ["terraform"]
			"runs-on": "ubuntu-latest"
			if:        "github.event_name =='push'"
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
				#actions.with.decryptionKey & #actions.secrets.decrypt,
				#actions.secrets.import,
				#actions.with.decryptionKey & #actions.secrets.decrypt & {
					#package: "github.com/augustfengd/augustfeng.app/cloud/kubernetes/prometheus"
				},
				#actions.secrets.import & {
					#package: "github.com/augustfengd/augustfeng.app/cloud/kubernetes/prometheus"
				},
				#actions.cue.command & {
					#command: "apply"
					#package: "github.com/augustfengd/augustfeng.app/cloud/kubernetes/prometheus"
				},
			]
			container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
		}
	}
}
