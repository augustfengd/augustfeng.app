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
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & _#make,
			{
				run: "tar cvz cloud/secrets | age -r age13x2cud63r8fr9qjlqdxjcuahlzxh3rvpgx6vgl263dkk2ghgpckqrg5r7p > secrets.tar.gz.age"
			},
			{
				uses: "actions/upload-artifact@v3"
				with: {
					name: "secrets.tar.gz.age"
					path: "secrets.tar.gz.age"
				}
			},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"configure": {
		needs: ["build"]
		"runs-on": "ubuntu-latest"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & {
				name:                "Decrypt and Convert Secrets"
				run:                 "cue decrypt && cue convert"
				"working-directory": "cloud/secrets"
			},
			{
				name: "Configure workspace"
				run:  "cue configure ./cloud/augustfeng.app:terraform"
			},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"terraform-plan": {
		needs: ["build", "configure"]
		"runs-on": "ubuntu-latest"
		if:        "github.event_name == 'pull_request'"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & _#make,
			_#terraformInit & {"working-directory": "build/terraform"},
			_#terraformPlan & {"working-directory": "build/terraform"},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"terraform-apply": {
		needs: ["build", "configure"]
		"runs-on": "ubuntu-latest"
		if:        "github.event_name =='push'"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & _#make,
			_#terraformInit & {"working-directory":  "build/terraform"},
			_#terraformApply & {"working-directory": "build/terraform"},
		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"argocd-apply": {
		needs: ["terraform-apply", "build"]
		"runs-on": "ubuntu-latest"
		if:        "github.event_name =='push'"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & {
				name:                "Decrypt and Convert Secrets"
				run:                 "cue decrypt && cue convert"
				"working-directory": "cloud/secrets"
			},
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
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"argocd-diff": {
		needs: ["build"]
		"runs-on": "ubuntu-latest"
		// NOTE: activate for testing
		// if:        "github.event_name == 'pull_request'"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & {
				name:                "Decrypt and Convert Secrets"
				run:                 "cue decrypt && cue convert"
				"working-directory": "cloud/secrets"
			},
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
		container: image: "ghcr.io/augustfengd/toolchain:latest"
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
	name?:                string
	run:                  string
	"working-directory"?: string
}

_#make: {
	_target: string

	env?: [string]: string
	name?: string
	run:   "make \(_target)" | *"make"
}

_#terraformInit: {
	id:                   "init"
	name:                 "Terraform Init"
	run:                  "terraform init"
	"working-directory"?: string
}

_#terraformPlan: {
	id:                   "plan"
	name:                 "Terraform Plan"
	run:                  "terraform plan"
	"working-directory"?: string
}

_#terraformApply: {
	id:                   "apply"
	name:                 "Terraform Apply"
	run:                  "terraform apply -auto-approve"
	"working-directory"?: string
}
