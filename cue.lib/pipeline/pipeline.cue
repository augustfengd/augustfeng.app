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

	addGitSafeDirectory: github.#Workflow.#Step & {
		#directory: string

		name: "add safe directory"
		run:  "git config --global --add safe.directory \(#directory)"
	}

	artifact: {
		upload: github.#Workflow.#Step & {
			uses: "actions/upload-artifact@v3"
			with: {
				name: string
				path: string
			}
		}
		download: github.#Workflow.#Step & {
			uses: "actions/download-artifact@v3"
			with: {
				name: string
				path: string
			}
		}
	}

	gcloud: {
		auth: github.#Workflow.#Step & {
			name: "configure google application credentials"
			uses: "google-github-actions/auth@v1"
			with: credentials_json: "${{ secrets.GOOGLE_CREDENTIALS }}"
		}
		command: github.#Workflow.#Step & {
			#command: string
			#flags: [string]: string | *null

			let flags = strings.Join([ for flag, value in #flags {
				if value != null {
					"\(flag)=\(value)"
				}
				if value == null {
					"\(flag)"
				}
			}], " ")

			name: "gcloud \(#command)"
			run:  "gcloud \(#command) \(flags)"
		}
		"install": install.gcloud
	}

	docker: login: github.#Workflow.#Step & {
		name: "docker login"
		run:  "echo \"${{ secrets.GITHUB_TOKEN }}\" | docker login ghcr.io -u $ --password-stdin"
	}

	skaffold: {
		command: {
			#command: string
			#flags: [string]: string | *null

			let flags = strings.Join([ for flag, value in #flags {
				if value != null {
					"\(flag)=\(value)"
				}
				if value == null {
					"\(flag)"
				}
			}], " ")

			name: "skaffold \(#command)"
			run:  "skaffold \(#command) \(flags)"
		}
		"install": install.skaffold
	}
	install: {
		sops: {
			#version: string | *"v3.7.3"
			name:     "install SOPS"
			run:      """
				mkdir -p bin/
				curl -Lo bin/sops https://github.com/mozilla/sops/releases/download/\(#version)/sops-\(#version).linux.amd64
				chmod +x bin/sops
				echo "${GITHUB_WORKSPACE}/bin" >> $GITHUB_PATH
				"""
		}
		skaffold: {
			name: "install skaffold"
			run: """
				mkdir -p bin/
				curl -Lo bin/skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
				chmod +x bin/skaffold
				echo "${GITHUB_WORKSPACE}/bin" >> $GITHUB_PATH
				"""
		}
		gcloud: github.#Workflow.#Step & {
			name: "install gcloud"
			uses: "google-github-actions/setup-gcloud@v1"
		}
		just: github.#Workflow.#Step & {
			name: "install just"
			uses: "extractions/setup-just@v1"
		}
	}

	secrets: {
		decrypt: github.#Workflow.#Step & {
			name: "decrypt secrets"
			run:  "cue decrypt github.com/augustfengd/augustfeng.app/secrets"
		}
		import: github.#Workflow.#Step & {
			name: "import secrets"
			run:  "cue convert github.com/augustfengd/augustfeng.app/secrets"
		}
	}

	with: {
		decryptionKey: github.#Workflow.#Step & {
			env: SOPS_AGE_KEY: "${{ secrets.SOPS_AGE_KEY }}"
		}
	}

	cue: {
		command: github.#Workflow.#Step & {
			#command: string
			#package: string

			name: "cue cmd \(#command) \(#package)"
			run:  "cue cmd \(#command) \(#package)"
		}
	}
	just: {
		run: github.#Workflow.#Step & {
			#recipe: string

			name:  "just \(#recipe)"
			"run": "just \(#recipe)"
		}
		"install": install.just
	}
}
