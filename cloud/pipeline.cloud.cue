package pipeline_old

import (
	"github.com/SchemaStore/schemastore/src/schemas/json/github"
)

#DefaultBranch: "main"

name: "cloud"
on: push: branches:         #DefaultBranch
on: pull_request: branches: #DefaultBranch
on: [string]: paths: ["cloud/**", "cue.mod/**"]

concurrency: "augustfeng.app.old"

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
		container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
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
		container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
	}
	"terraform-plan": {
		name: "terraform (plan)"
		needs: ["build", "configure"]
		"runs-on": "ubuntu-latest"
		if:        "github.event_name == 'pull_request'"
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			#actions.terraform.init & {"working-directory": "build/terraform"},
			#actions.terraform.plan & {"working-directory": "build/terraform"},
		]
		container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
	}
	"terraform-apply": {
		name: "terraform (apply)"
		needs: ["build", "configure"]
		"runs-on": "ubuntu-latest"
		if:        "github.event_name =='push'"
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			#actions.terraform.init & {"working-directory":  "build/terraform"},
			#actions.terraform.apply & {"working-directory": "build/terraform"},
		]
		container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
	}
	"cluster-services-apply": {
		name: "cluster services (apply)"
		needs: ["terraform-apply", "build"]
		"runs-on": "ubuntu-latest"
		env: {
			GOOGLE_CREDENTIALS:             "${{ secrets.GOOGLE_CREDENTIALS }}"
			GOOGLE_APPLICATION_CREDENTIALS: "application_default_credentials.json"
			KUBECONFIG:                     "kubeconfig.yaml"
		}
		if: "github.event_name =='push'"
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			#actions.run & {
				run: "printf '%s' \"${GOOGLE_CREDENTIALS}\" > \"${GOOGLE_APPLICATION_CREDENTIALS}\""
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
			// appofapps
			#actions.run & {
				run: "cue export ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(appofapps.manifests)' --out text | kubectl -n argocd apply -f -"
			},
			#actions.run & {
				run: "timeout 1m sh -c 'until kubectl get crds ingressroutes.traefik.containo.us; do sleep 5; done'"
			},
			#actions.run & {
				run: "kubectl -n argocd apply -f build/argocd/traefik.containo.us"
			},
			// cert-manager related manifests
			#actions.run & {
				run: "timeout 1m sh -c 'until kubectl get crds certificates.cert-manager.io; do sleep 5; done'"
			},
			#actions.run & {
				run: "kubectl -n argocd apply -f build/argocd/cert-manager.io"
			},
		]
		container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
	}
	"cluster-services-diff": {
		name: "cluster services (diff)"
		needs: ["build"]
		"runs-on": "ubuntu-latest"
		env: {
			GOOGLE_CREDENTIALS:             "${{ secrets.GOOGLE_CREDENTIALS }}"
			GOOGLE_APPLICATION_CREDENTIALS: "application_default_credentials.json"
			KUBECONFIG:                     "kubeconfig.yaml"
		}
		if: "github.event_name == 'pull_request'"
		steps: [...{if: "env.GOOGLE_CREDENTIALS != ''"}]
		steps: [
			#actions.checkoutCode,
			#actions.with.decryptionKey & #actions.make,
			#actions.run & {
				run: "printf '%s' \"${GOOGLE_CREDENTIALS}\" > \"${GOOGLE_APPLICATION_CREDENTIALS}\""
			},
			#actions.run & {
				run: "kubectl diff -n argocd -f build/argocd" // TODO: fails on first run because we have custom resource definitions and custom resource objects.
			},
		]
		container: image: "ghcr.io/augustfengd/augustfeng.app/toolchain:latest"
	}
}
