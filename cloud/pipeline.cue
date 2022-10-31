package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
)

#DefaultBranch: "main"

name: "cloud"
on: push: branches:         #DefaultBranch
on: pull_request: branches: #DefaultBranch
on: [string]: paths: ["cloud/**"]

concurrency: "augustfeng.app"

jobs: github.#Workflow.#Jobs & {
	"build": {
		"runs-on": "ubuntu-latest"
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			// NOTE: encrypt and upload build results as artifacts, but .. we rebuild in each job because it's simpler and faster(?).
			#actions.run & {
				name: "Archive Build"
				run:  "tar cvz build | age -r age13x2cud63r8fr9qjlqdxjcuahlzxh3rvpgx6vgl263dkk2ghgpckqrg5r7p > build.tar.gz.age"
			},
			#actions.uploadArtifact & {
				with: {
					name: "build.tar.gz.age"
					path: "build.tar.gz.age"
				}
			},
			#actions.run & {
				name: "Archive Secrets"
				run:  "tar cvz cloud/secrets | age -r age13x2cud63r8fr9qjlqdxjcuahlzxh3rvpgx6vgl263dkk2ghgpckqrg5r7p > secrets.tar.gz.age"
			},
			#actions.uploadArtifact & {
				with: {
					name: "secrets.tar.gz.age"
					path: "secrets.tar.gz.age"
				}
			},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"configure": {
		name: "terraform cloud"
		needs: ["build"]
		"runs-on": "ubuntu-latest"
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			#actions.run & {
				name: "Configure workspace"
				run:  "cue configure ./cloud/augustfeng.app:terraform"
			},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"terraform-plan": {
		name: "terraform plan"
		needs: ["build", "configure"]
		"runs-on": "ubuntu-latest"
		if:        "github.event_name == 'pull_request'"
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			#actions.terraform.init & {"working-directory": "build/terraform"},
			#actions.terraform.plan & {"working-directory": "build/terraform"},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"terraform-apply": {
		name: "terraform apply"
		needs: ["build", "configure"]
		"runs-on": "ubuntu-latest"
		if:        "github.event_name =='push'"
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			#actions.terraform.init & {"working-directory":  "build/terraform"},
			#actions.terraform.apply & {"working-directory": "build/terraform"},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"cluster-services-apply": {
		name: "argocd (apply)"
		needs: ["terraform-apply", "build"]
		"runs-on": "ubuntu-latest"
		env: GOOGLE_CREDENTIALS: "${{ secrets.GOOGLE_CREDENTIALS }}"
		if: "github.event_name =='push'"
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			#actions.run & {
				name: "gcloud-auth"
				run:  "/opt/google-cloud-sdk/bin/gcloud auth login --cred-file <(printf '%s\n' ${GOOGLE_CREDENTIALS})"
			},
			#actions.run & {
				// env: USE_GKE_GCLOUD_AUTH_PLUGIN: "True"
				name: "gcloud-container-clusters"
				run:  "/opt/google-cloud-sdk/bin/gcloud container clusters get-credentials augustfeng-app --zone us-east1-b --project augustfengd"
			},
			#actions.run & {
				run: "kubectl create ns argocd --dry-run=client -oyaml | kubectl apply -f -"
			},
			#actions.run & {
				run: "kubectl -n argocd apply -f build/argocd/crds"
			},
			#actions.run & {
				run: "kubectl -n argocd apply -f build/argocd"
			},

		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"cluster-services-diff": {
		name: "argocd (diff)"
		needs: ["build"]
		"runs-on": "ubuntu-latest"
		env: GOOGLE_CREDENTIALS: "${{ secrets.GOOGLE_CREDENTIALS }}"
		if: "github.event_name == 'pull_request'"
		steps: [...{if: "env.GOOGLE_CREDENTIALS != ''"}]
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			{
				name: "gcloud-auth"
				run:  "/opt/google-cloud-sdk/bin/gcloud auth login --cred-file <(printf '%s\n' ${GOOGLE_CREDENTIALS})"
			},
			{
				// env: USE_GKE_GCLOUD_AUTH_PLUGIN: "True"
				name: "gcloud-container-clusters"
				run:  "/opt/google-cloud-sdk/bin/gcloud container clusters get-credentials augustfeng-app --zone us-east1-b --project augustfengd"
			},
			{
				run: "kubectl diff -f build/argocd" // TODO: we have crd and crd objects.
			},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
}

#actions: {
	terraform: {
		init: github.#Workflow.#Step & {
			name: "Terraform Init"
			id:   "init"
			run:  "terraform init"
		}
		plan: github.#Workflow.#Step & {
			name: "Terraform Plan"
			id:   "plan"
			run:  "terraform plan"
		}
		apply: github.#Workflow.#Step & {
			name: "Terraform Apply"
			id:   "apply"
			run:  "terraform apply -auto-approve"
		}
	}

	run: github.#Workflow.#Step & {
		run: string
	}

	make: github.#Workflow.#Step & {
		_target: string

		name: "make \(_target)" | *"make"
		run:  "make \(_target)" | *"make"
	}

	checkoutCode: github.#Workflow.#Step & {
		name: "Checkout code"
		uses: "actions/checkout@v3"
	}

	uploadArtifact: github.#Workflow.#Step & {
		uses: "actions/upload-artifact@v3"
		with: {
			name: string
			path: string
		}
	}

	with: {
		decryptionKey: github.#Workflow.#Step & {
			env: SOPS_AGE_KEY: "${{ secrets.SOPS_AGE_KEY }}"
		}
	}
}
