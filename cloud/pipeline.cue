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

jobs: github.#Workflow.#jobs & {
	"build": {
		"runs-on": "ubuntu-latest"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & _#make,
			// NOTE: encrypt and upload build results as artifacts, but .. we rebuild in each job because it's simpler and faster(?).
			{
				name: "archive"
				run:  "tar cvz build | age -r age13x2cud63r8fr9qjlqdxjcuahlzxh3rvpgx6vgl263dkk2ghgpckqrg5r7p > build.tar.gz.age"
			},
			{
				uses: "actions/upload-artifact@v3"
				with: {
					name: "build.tar.gz.age"
					path: "build.tar.gz.age"
				}
			},
			{
				name: "archive"
				run:  "tar cvz cloud/secrets | age -r age13x2cud63r8fr9qjlqdxjcuahlzxh3rvpgx6vgl263dkk2ghgpckqrg5r7p > secrets.tar.gz.age"
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
			_#withDecryptionKey & _#make,
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
		env: GOOGLE_CREDENTIALS: "${{ secrets.GOOGLE_CREDENTIALS }}"
		if: "github.event_name =='push'"
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & _#make,
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
				run: "kubectl create ns argocd --dry-run=client -oyaml | kubectl apply -f -"
			},
			{
				run: "kubectl apply -f build/argocd/crds"
			},
			{
				run: "kubectl apply -f build/argocd"
			},

		]
		container: image: "ghcr.io/augustfengd/toolchain:latest"
	}
	"argocd-diff": {
		needs: ["build"]
		"runs-on": "ubuntu-latest"
		env: GOOGLE_CREDENTIALS: "${{ secrets.GOOGLE_CREDENTIALS }}"
		if: "github.event_name == 'pull_request'"
		steps: [...{if: "env.GOOGLE_CREDENTIALS != ''"}]
		steps: [
			_#checkoutCode,
			_#withDecryptionKey & _#make,
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

_#checkoutCode: {
	name: "Checkout code"
	if?:  string
	uses: "actions/checkout@v3"
}

_#withDecryptionKey: {
	name?: string
	env: {
		SOPS_AGE_KEY: "${{ secrets.SOPS_AGE_KEY }}"
	}
	if?:                  string
	run:                  string
	"working-directory"?: string
}

_#make: {
	_target: string

	name?: string
	env?: [string]: string
	if?: string
	run: "make \(_target)" | *"make"
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
