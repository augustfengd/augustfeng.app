package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
)

#DefaultBranch: "main"

name: "cloud"
on: push: branches:         #DefaultBranch
on: pull_request: branches: #DefaultBranch
on: [string]: paths: ["cloud/**"]

jobs: github.#Workflow.#jobs & {
	"build": {
		"runs-on": "ubuntu-latest"
		container: image: "ghcr.io/augustfengd/toolchain:latest"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & {
				name: "make"
				run:  "make"
			},
		]
	}
	"configure": {
		needs: ["build"]
		"runs-on": "ubuntu-latest"
		container: image: "ghcr.io/augustfengd/toolchain:latest"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & {
				name:                "Decrypt and convert secrets"
				run:                 "cue decrypt && cue convert"
				"working-directory": "cloud/secrets"
			},
			{
				name: "Configure workspace"
				run:  "cue configure ./cloud/augustfeng.app:terraform"
			},
		]
	}
	"plan": {
		needs: ["build", "configure"]
		if:        "github.event_name == 'pull_request'"
		"runs-on": "ubuntu-latest"
		container: image: "ghcr.io/augustfengd/toolchain:latest"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & {
				name: "make"
				run:  "make"
			},
			_#terraformInit & {"working-directory": "build/terraform"},
			_#terraformPlan & {"working-directory": "build/terraform"},
		]
	}
	"apply": {
		needs: ["build", "configure"]
		if:        "github.event_name =='push'"
		"runs-on": "ubuntu-latest"
		container: image: "ghcr.io/augustfengd/toolchain:latest"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & {
				name: "make"
				run:  "make"
			},
			_#terraformInit & {"working-directory":  "build/terraform"},
			_#terraformApply & {"working-directory": "build/terraform"},
		]
	}
	"argocd": {
		needs: ["apply"]
		if:        "github.event_name =='push'"
		"runs-on": "ubuntu-latest"
		container: image: "ghcr.io/augustfengd/toolchain:latest"
		steps: [
			_#checkoutCode,
			{
				env: GOOGLE_CREDENTIALS: "${{ secrets.GOOGLE_CREDENTIALS }}"
				name: "gcloud-auth"
				run:  "/opt/google-cloud-sdk/bin/gcloud auth login --cred-file <(printf '%s\n' ${GOOGLE_CREDENTIALS})"
			},
			{
				// env: USE_GKE_GCLOUD_AUTH_PLUGIN: "True"
				name: "gcloud-container-clusters"
				run:  "/opt/google-cloud-sdk/bin/gcloud container clusters get-credentials augustfeng-app --zone us-east1-b --project augustfengd"
			},
			{
				name: "build"
				run:  "jsonnet -m build/argocd -c cloud/argocd/argocd.jsonnet --tla-str fqdn=argocd.augustfeng.app --tla-code-file argocdCmpSecrets=cloud/secrets/sops-secrets.json"
			},
		]
	}
}

_#checkoutCode: {
	name: "Checkout code"
	uses: "actions/checkout@v3"
}

_#withDecryptionKey: {
	env: {
		SOPS_AGE_KEY: "${{ secrets.SOPS_AGE_KEY }}"
	}
	name:                 string
	run:                  string
	"working-directory"?: string
}

_#terraformInit: {
	name:                 "Terraform Init"
	id:                   "init"
	run:                  "terraform init"
	"working-directory"?: string
}

_#terraformPlan: {
	name:                 "Terraform Plan"
	id:                   "plan"
	run:                  "terraform plan"
	"working-directory"?: string
}

_#terraformApply: {
	name:                 "Terraform Apply"
	id:                   "apply"
	run:                  "terraform apply -auto-approve"
	"working-directory"?: string
}
