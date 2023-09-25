package ansible

import (
	"tool/file"
	"encoding/yaml"
)

output: {
	ansibleCfg: string
	inventory: {}
	installKubernetes: {}
}

command: build: {
	dir: file.Mkdir & {
		path: "build"
	}
	inventory: file.Create & {
		$dep:     dir.$done
		filename: dir.path + "/inventory.yaml"
		contents: yaml.Marshal(output.inventory)
	}
	ansibleCfg: file.Create & {
		$dep:     dir.$done
		filename: dir.path + "/ansible.cfg"
		contents: output.ansibleCfg
	}
	playbooks: {
		dir: file.Mkdir & {
			$dep: build.dir.$done
			path: build.dir.path + "/playbooks"
		}
		installKubernetes: file.Create & {
			$dep:     dir.$done
			filename: dir.path + "/installKubernetes.yaml"
			contents: yaml.Marshal(output.playbooks.installKubernetes)
		}

	}
}
