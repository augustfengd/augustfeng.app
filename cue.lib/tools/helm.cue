package helm

import (
	"tool/exec"
	"encoding/yaml"
)

#namespace: string
#name:      string
#chart:     string
#version:   string
#values: {}

#repo: {
	name: string
	url:  string
}

command: "repo.add": exec.Run & {
	cmd: "helm repo add \(#repo.name) \(#repo.url)"
}

command: template: exec.Run & {
	cmd:   "helm template --namespace \(#namespace) \(#name) \(#chart) --version \(#version) -f -"
	stdin: yaml.Marshal(#values)
}

command: diff: {
	manifests: command.template & {
		stdout: string
	}
	diff: exec.Run & {
		cmd:   "kubectl diff -f -"
		stdin: manifests.stdout
	}
}

command: install: exec.Run & {
	cmd:   "helm upgrade --install --namespace \(#namespace) \(#name) \(#chart) --version \(#version) -f -"
	stdin: yaml.Marshal(#values)
}
