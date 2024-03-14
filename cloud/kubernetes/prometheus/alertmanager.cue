package prometheus

import "github.com/augustfengd/augustfeng.app/cloud/kubernetes/prometheus/secrets"

alertmanager: manifests: [{
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "Alertmanager"
	metadata: name: "alertmanager"
	spec: replicas: 1
	spec: alertmanagerConfiguration: name: "discord"
}]

alertmanagerconfig: manifests: [{
	apiVersion: "monitoring.coreos.com/v1alpha1"
	kind:       "AlertmanagerConfig"
	metadata: name: "discord"
	spec: route: {
		groupBy: ["job"]
		groupWait:      "30s"
		groupInterval:  "5m"
		repeatInterval: "12h"
		receiver:       "discord"
	}
	spec: receivers: [{
		name: "discord"
		webhookConfigs: [{
			url: secrets["discord.json"]["augustfeng-app"]
		}]
	}]

}]
