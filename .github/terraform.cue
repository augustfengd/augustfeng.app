package terraform

import (
	"strings"
)

#c: {
	default_branch: string | *"main"
	terraform: version: string | *"v1.2.3"
	terraform: workspace: hostname: string | *"app.terraform.io"
}

name: "Terraform"
on: push: branches:         #c.default_branch
on: pull_request: branches: #c.default_branch
jobs: {
	"generate": {
		steps: [
			_#setupTerraform,
			_#checkoutCode,
			_#installSops & {#v: "v3.7.3"},
			_#installCue & {#v:  "v0.4.3"},
			_#withDecryptionKey & _#make,
		]
	}
	"configure": {
		needs: ["generate"]
		steps: [
			_#setupTerraform & _#withTerraformCredentials,
			_#checkoutCode,
			_#installSops & {#v: "v3.7.3"},
			_#installCue & {#v:  "v0.4.3"},
			_#withDecryptionKey & _#make,
			_#terraformInit & {"working-directory": "build/terraform"},
			_#withDecryptionKey & {
				name:                "Decrypt secrets"
				run:                 "cue decrypt"
				"working-directory": "terraform/secrets"
			},
			_#withDecryptionKey & {
				name:                "Convert secrets"
				run:                 "cue convert"
				"working-directory": "terraform/secrets"
			},
			_#configureWorkspace & {
				name:                "Configure workspace"
				run:                 "cue configure :scripts"
				"working-directory": "terraform"
			},
		]
	}
	"plan": {
		needs: ["generate", "configure"]
		if: "github.event_name == 'pull_request'"
		steps: [
			_#setupTerraform & _#withTerraformCredentials,
			_#checkoutCode,
			_#installSops & {#v: "v3.7.3"},
			_#installCue & {#v:  "v0.4.3"},
			_#withDecryptionKey & _#make,
			_#terraformInit & {"working-directory": "build/terraform"},
			_#terraformPlan & {"working-directory": "build/terraform"},
		]
	}
	"apply": {
		needs: ["generate", "configure"]
		if: "github.event_name =='push'"
		steps: [
			_#setupTerraform & _#withTerraformCredentials,
			_#checkoutCode,
			_#installSops & {#v: "v3.7.3"},
			_#installCue & {#v:  "v0.4.3"},
			_#withDecryptionKey & _#make,
			_#terraformInit & {"working-directory":  "build/terraform"},
			_#terraformApply & {"working-directory": "build/terraform"},
		]
	}
	"finish": {
		needs: ["apply"]
		if: "github.event_name =='push'"
		steps: [
			_#checkoutCode,
			// add some epilogue tasks
		]
	}
} & {
	[op=string]: {
		"runs-on": "ubuntu-latest"
		name:      op
	}
}

_#make: {
	// TODO: will learn and elaborate more when Makefile is more complete.
	name: "make"
	id:   "make"
	run:  "make"
	env: [string]: string
}

_#terraformFmt: {
	name:                 "Terraform Format"
	id:                   "fmt"
	run:                  "terraform fmt -check -recursive -diff"
	"working-directory"?: string
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

_#checkoutCode: {
	name: "Checkout code"
	uses: "actions/checkout@v3"
}

_#setupTerraform: {
	name: "Setup Terraform"
	uses: "hashicorp/setup-terraform@v2"
	with: {
		terraform_version: #c.terraform.version
		...
	}
}

_#withTerraformCredentials: {
	_#setupTerraform
	with: {
		cli_config_credentials_hostname: #c.terraform.workspace.hostname
		cli_config_credentials_token:    "${{ secrets.TF_API_TOKEN }}"
	}
}

_#installSops: {
	name: "Install sops"
	id:   "sops"
	#v:   =~"v[0-9]+\\.[0-9]+\\.[0-9]+"
	run:  """
	mkdir -p bin/
	curl -L --output bin/sops https://github.com/mozilla/sops/releases/download/\(#v)/sops-\(#v).linux.amd64
	chmod +x bin/sops
	echo "${GITHUB_WORKSPACE}/bin" >> $GITHUB_PATH
	"""
}

_#installCue: {
	name: "Install cue"
	id:   "cue"
	#v:   =~"v[0-9]+\\.[0-9]+\\.[0-9]+"
	run:  """
	mkdir -p bin/
	curl -L --output - https://github.com/cue-lang/cue/releases/download/\(#v)/cue_\(#v)_linux_amd64.tar.gz | tar xzf - -C bin/ cue
	echo "${GITHUB_WORKSPACE}/bin" >> $GITHUB_PATH
	"""
}

_#withDecryptionKey: {
	env: {
		SOPS_AGE_KEY: "${{ secrets.SOPS_AGE_KEY }}"
	}
	...
}

_#configureWorkspace: {
	env: {
		(strings.Replace("TF_TOKEN_\(#c.terraform.workspace.hostname)", ".", "_", -1)): "${{ secrets.TF_API_TOKEN }}"
	}
	...
}
