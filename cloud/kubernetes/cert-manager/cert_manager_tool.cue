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
	#name:      "cert-manager"
	#chart:     "jetstack/cert-manager"
	#version:   "v1.11.0"
	#values:    values
}

k: kubectl & {
	#namespace: "system-ingress"
	#manifests: manifests
}

command: template: {
	a:           h.command.template & {stdout: string}
	b:           k.command.template & {stdout: string}
	concatenate: exec.Run & {
		cmd:   "cat"
		stdin: yaml.MarshalStream(
			yaml.UnmarshalStream(a.stdout) +
			yaml.UnmarshalStream(b.stdout),
			)
	}
}

command: diff: {
	a:           h.command.template & {stdout: string}
	b:           k.command.template & {stdout: string}
	concatenate: exec.Run & {
		cmd:   "kubectl diff -f -"
		stdin: yaml.MarshalStream(
			yaml.UnmarshalStream(a.stdout) +
			yaml.UnmarshalStream(b.stdout),
			)
	}
}

command: install: {
	"helm":    h.command.install
	"kubectl": k.command.apply & {"0": $dep: command.install."helm".$done}
}
