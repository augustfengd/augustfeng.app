package cert_manager

import (
	"encoding/yaml"
	"tool/exec"

	"github.com/augustfengd/augustfeng.app/cue.lib/tools:helm"
	"github.com/augustfengd/augustfeng.app/cue.lib/tools:kubectl"
)

values: {}
manifests: [
	clusterissuer.manifests,
	secrets.manifests,
]

h: helm & {
	#namespace: "system-ingress"
	#name:      "foobar"
	#chart:     "jetstack/cert-manager"
	#values:    values
}

k: kubectl & {
	#namespace: "system-ingress"
	#manifests: manifests
}

command: template: {
	"helm":      h.command.template & {stdout: string}
	"kubectl":   k.command.template & {stdout: string}
	concatenate: exec.Run & {
		cmd:   "cat"
		stdin: yaml.MarshalStream(
			yaml.UnmarshalStream(template."helm".stdout) +
			yaml.UnmarshalStream(template."kubectl".stdout),
			)
	}
}

command: diff: {
	"helm":      h.command.template & {stdout: string}
	"kubectl":   k.command.template & {stdout: string}
	concatenate: exec.Run & {
		cmd:   "kubectl diff -f -"
		stdin: yaml.MarshalStream(
			yaml.UnmarshalStream(diff."helm".stdout) +
			yaml.UnmarshalStream(diff."kubectl".stdout),
			)
	}
}

command: install: {
	"helm":    h.command.install
	"kubectl": k.command.apply & {"0": $dep: command.install."helm".$done}
}
