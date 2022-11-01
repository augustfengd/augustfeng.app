package vendor

import (
	"strings"

	"path"

	"tool/exec"
	"tool/http"
	"tool/file"
)

#root: exec.Run & {
	cmd:    "git rev-parse --show-toplevel"
	stdout: string
	dir:    strings.TrimSpace(stdout)
}

command: importdefinitions: {
	root: #root
	k8s: {
		go: exec.Run & {
			version: "kubernetes-1.25.3"
			cmd:     "go get k8s.io/api/...@" + (version)
			dir:     root.dir
		}
		cue: exec.Run & {
			$dep: go.$done
			cmd:  "cue get go k8s.io/api/..."
			dir:  root.dir
		}
	}
	argocd: {
		go: exec.Run & {
			version: "v2.5.0"

			cmd: "go get github.com/argoproj/argo-cd/v2@" + (version)
			dir: root.dir
		}
		cue: exec.Run & {
			$dep: go.$done
			cmd:  "cue get go github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"
			dir:  root.dir
		}
	}
	traefik: {
		go: exec.Run & {
			version: "v2.9.4"

			cmd: "go get github.com/traefik/traefik/v2@" + (version)
			dir: root.dir
		}
		cue: exec.Run & {
			$dep: go.$done
			cmd:  "cue get go github.com/traefik/traefik/v2/pkg/provider/kubernetes/crd/traefik/v1alpha1"
			dir:  root.dir
		}
		// crypto/tls is imported at cue.mod/gen but CUE thinks it's builtin.
		patch: exec.Run & {
			$dep: cue.$done
			cmd: ["gsed", "-i", "s/import \"crypto\\/tls\"/tls: #Certificate: _/", "cue.mod/gen/github.com/traefik/traefik/v2/pkg/tls/certificate_store_go_gen.cue"]
			dir: root.dir
		}
	}
	// NOTE: this command originates from cue's project.
	// https://github.com/cue-lang/cue/blob/master/internal/ci/vendor/vendor_tool.cue
	github: {
		getJSONSchema: http.Get & {
			request: body: ""

			// Tip link for humans:
			// https://github.com/SchemaStore/schemastore/blob/master/src/schemas/json/github-workflow.json
			url: "https://raw.githubusercontent.com/SchemaStore/schemastore/6fe4707b9d1c5d45cfc8d5b6d56968e65d2bdc38/src/schemas/json/github-workflow.json"
		}
		import: exec.Run & {
			_outpath: path.FromSlash("cue.mod/pkg/github.com/SchemaStore/schemastore/src/schemas/json/github/workflow.cue", "unix")
			stdin:    getJSONSchema.response.body
			cmd:      "cue import -f -p github -l #Workflow: -o \(_outpath) jsonschema: -"
			dir:      root.dir
		}
	}
}

command: clean: {
	root: #root
	k8s:  file.RemoveAll & {
		path: root.dir + "/" + "cue.mod/gen/k8s.io"
	}
	argocd: {
		argproj: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/github.com/argoproj"
		}
		time: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/time"
		}
	}
	traefik: {
		traefik: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/github.com/traefik"
		}
		context: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/context"
		}
		crypto: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/crypto"
		}
		encoding: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/encoding"
		}
		io: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/io"
		}
		net: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/io"
		}
		reflect: file.RemoveAll & {
			path: root.dir + "/" + "cue.mod/gen/reflect"
		}
	}
	gh: file.RemoveAll & {
		path: root.dir + "/" + "cue.mod/pkg/github.com"
	}
}
