package kubernetes

import (
	"encoding/yaml"
	"tool/exec"
	"tool/file"
)

command: apply: {// TODO: should apply the generated manifest files in a logical order ( CRD > Namespace > Rest ).
	#objects: [ for application in applications for resources in application for object in resources {object}]
	manifests: exec.Run & {
		cmd: ["kubectl", "apply", "-f", "-"]
		stdin: yaml.MarshalStream(#objects)
	}
}

command: build: {
	manifests: {
		for application in applications {
			(application.#name): {
				mkdir: file.MkdirAll & {
					path: "../build/kubernetes/\(application.#name)"
				}
				for resource, objects in application {
					(resource): file.Create & {
						$dep:     mkdir.$done
						filename: "../build/kubernetes/\(application.#name)/\(resource).yaml"
						contents: yaml.MarshalStream([ for object in objects {object}])
					}
				}
			}
		}
	}
}
