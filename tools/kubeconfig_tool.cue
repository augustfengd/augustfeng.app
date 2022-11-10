package kubeconfig

import (
	"tool/exec"
	// "tool/cli"
	"tool/file"
	"encoding/yaml"

	"github.com/augustfengd/augustfeng.app/tools:git"
)

#kubeconfig: {
	apiVersion:        "v1"
	kind:              "Config"
	"current-context": "augustfeng-app"
	contexts: [{
		name: "augustfeng-app"
		context: {
			cluster: "augustfeng-app"
			user:    "augustfengd"
		}
	}]
	users: [{
		name: "augustfengd"
		user: "auth-provider": name: "gcp"
	}]
	clusters: [{
		name: "augustfeng-app"
		cluster: {
			server:                       string
			"certificate-authority-data": string
		}
	}]
}

command: create: {
	root: git.#root

	cluster: exec.Run & {
		cmd:           "gcloud container clusters describe augustfeng-app --zone=us-east1-b"
		stdout:        string
		configuration: yaml.Unmarshal(stdout)
	}

	write: file.Create & {
		configuration: #kubeconfig & {
			clusters: [{
				"cluster": {
					server:                       "https://" + cluster.configuration.endpoint
					"certificate-authority-data": cluster.configuration.masterAuth.clusterCaCertificate
				}
			}]
		}
		contents: yaml.Marshal(configuration)
		filename: root.dir + "/kubeconfig.yaml"
	}
}
