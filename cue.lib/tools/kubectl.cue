package kubectl

import (
	"list"
	"tool/exec"
	"encoding/yaml"
)

#namespace: string
#manifests: [...[...]] & [...[...{metadata: namespace: string | *#namespace}]]

template: exec.Run & {
	cmd:   "cat"
	stdin: yaml.MarshalStream(list.FlattenN(#manifests, 1))
}

diff: exec.Run & {
	cmd:   "kubectl diff -f -"
	stdin: yaml.MarshalStream(list.FlattenN(#manifests, 1))
}

apply: steps: {
	for i, manifest in #manifests {
		"\(i)": exec.Run & {
			if i > 0 {
				$dep: steps["\(i-1)"].$done
			}

			cmd:   "kubectl apply -f -"
			stdin: yaml.MarshalStream(manifest)
		}
	}
}
