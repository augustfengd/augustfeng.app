package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
)

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

	install: {
		sops: {
			#version: string | *"v3.7.3"
			name:     "Install SOPS"
			run:      """
mkdir -p bin/
curl -L --output bin/sops https://github.com/mozilla/sops/releases/download/\(#version)/sops-\(#version).linux.amd64
chmod +x bin/sops
echo "${GITHUB_WORKSPACE}/bin" >> $GITHUB_PATH
"""
		}
	}

	with: {
		decryptionKey: github.#Workflow.#Step & {
			env: SOPS_AGE_KEY: "${{ secrets.SOPS_AGE_KEY }}"
		}
	}
}
