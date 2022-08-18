package terraform

import (
	"github.com/augustfengd/augustfeng.app/terraform:do"
	"github.com/augustfengd/augustfeng.app/terraform:gcp"
)

#c: {
	configuration: {
		"do":  do.#c | *null
		"gcp": gcp.#c | *null
	}
	workspace: {
		organization: string
		hostname:     string | *"app.terraform.io"
		name:         string
		settings: "terraform-version": string | *"1.2.7"
		vars: [... {
			key:          string
			value:        string
			category:     "hcl" | "env"
			sensitive:    bool | *false
			description?: string
		}]
		token: string
	}
}

for pkg, c in #c.configuration if c != null {
	let configuration = {"do": do, "gcp": gcp}[pkg] & {#c: c}
	for a, b in configuration if (a & string) != _|_ {// XXX: use proposed builtins when available: manifest(x)
		(a): (b)
	}
}

terraform: cloud: {
	organization: #c.workspace.organization
	hostname:     #c.workspace.hostname
	workspaces: {
		name: #c.workspace.name
	}
	token: #c.workspace.token
}
