package kubernetes

import (
	argocd "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"

	"encoding/yaml"
)

#application: {
	name:      string
	namespace: string
	helm:      {
		url:      string
		revision: string
		values:   _
		chart:    string
	} | *null
	plugin: {
		name: "cue"
		args: string
	} | *null

	manifests: [argocd.#Application & {
		metadata: "name": name
		spec: source: {
			if helm != null {
				repoURL:        helm.url
				targetRevision: helm.revision
				"helm": values: yaml.Marshal(helm.values)
				chart: helm.chart
			}

			if plugin != null {
				repoURL:        "https://github.com/augustfengd/augustfeng.app.git"
				path:           "."
				targetRevision: "main"

				"plugin": {
					name: plugin.name
					env: [ for k, v in plugin if k != "name" {
						name:  k
						value: v
					}]
				}
			}
		}
		spec: project: "cloud"
		spec: destination: "namespace": namespace
	}]
}
