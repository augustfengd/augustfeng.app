package pipeline

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
	"strings"
)

#actions: {
	terraform: {
		init: github.#Workflow.#Step & {
			name: "terraform init"
			id:   "init"
			run:  "terraform init"
		}
		plan: github.#Workflow.#Step & {
			name: "terraform plan"
			id:   "plan"
			run:  "terraform plan"
		}
		apply: github.#Workflow.#Step & {
			name: "terraform apply"
			id:   "apply"
			run:  "terraform apply -auto-approve"
		}
	}

	run: github.#Workflow.#Step & {
		run: string
	}

	make: github.#Workflow.#Step & {
		#target: string | *"" // not a fan of using definitiosn for interfacing,but whatever.

		name: run
		run:  strings.Join( [ "make", if #target != "" {#target}], " ")
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

	gcp: login: github.#Workflow.#Step & {
		name: "configure google application credentials"
		env: {
			GOOGLE_CREDENTIALS:             string
			GOOGLE_APPLICATION_CREDENTIALS: string
		}
		run: "printf '%s' \"${GOOGLE_CREDENTIALS}\" > \"${GOOGLE_APPLICATION_CREDENTIALS}\""
	}

	docker: login: github.#Workflow.#Step & {
		name: "docker login"
		run:  "echo \"${{ secrets.GITHUB_TOKEN }}\" | docker login ghcr.io -u $ --password-stdin"
	}

	install: {
		sops: {
			#version: string | *"v3.7.3"
			name:     "install SOPS"
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
