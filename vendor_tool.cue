// Copyright 2021 The CUE Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package vendor

import (
	"path"

	"tool/exec"
	"tool/http"
)

// For the commands below, note we use simple yet hacky path resolution, rather
// than anything that might derive the module root using go list or similar, in
// order that we have zero dependencies.

// importjsonschema vendors a CUE-imported version of the JSONSchema that
// defines GitHub workflows into the main module's cue.mod/pkg.
command: importschema: {
	k8s: {
		go: exec.Run & {
			cmd: "go get k8s.io/api/...@kubernetes-1.25.3"
		}
		cue: exec.Run & {
			$dep: go.$done
			cmd:  "cue get go k8s.io/api/..."
		}
	}

	// NOTE: this command originates from
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
		}
	}
}
