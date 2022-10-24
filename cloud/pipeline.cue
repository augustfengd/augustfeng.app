package pipeline

#DefaultBranch:    "main"
#TerraformVersion: string

name: "cloud"
on: push: branches:         #DefaultBranch
on: pull_request: branches: #DefaultBranch
on: [string]: paths: ["cloud/**"]

jobs: {
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
				"working-directory": "cloud/_secrets"
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
	"finish": {
		needs: ["apply"]
		if:        "github.event_name =='push'"
		"runs-on": "ubuntu-latest"
		container: image: "ghcr.io/augustfengd/toolchain:latest"
		steps: [
			_#checkoutCode,
			// add some epilogue tasks
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
	...
}

_#terraformInit: {
	name:                "Terraform Init"
	id:                  "init"
	run:                 "terraform init"
	"working-directory": string
}

_#terraformPlan: {
	name:                "Terraform Plan"
	id:                  "plan"
	run:                 "terraform plan"
	"working-directory": string
}

_#terraformApply: {
	name:                "Terraform Apply"
	id:                  "apply"
	run:                 "terraform apply -auto-approve"
	"working-directory": string
}
