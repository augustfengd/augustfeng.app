package kubernetes

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

app: {
	deployment: kubernetes.#deployment & {
		image: {
			name: "ghcr.io/augustfengd/augustfeng.app/domain"
		}
		sa: "domain-controller"
		manifests: [{metadata: namespace: "system-ingress"}]
	}

	// use cronjob until i create a controller-based workload
	cronjob: manifests: [{
		apiVersion: "batch/v1"
		kind:       "CronJob"
		metadata: {
			name:      "domain"
			namespace: "system-ingress"
			labels: "app.kubernetes.io/name": "domain"
		}
		spec: {
			schedule: "0 * * * *"
			jobTemplate: spec: template: spec: {
				serviceAccountName: "domain-controller"
				containers: [{
					name:  "domain"
					image: "ghcr.io/augustfengd/augustfeng.app/domain"
				}]
				restartPolicy: "Never"
			}
		}
	}]

	// abstract me later
	rbac: manifests: [
		{
			apiVersion: "v1"
			kind:       "ServiceAccount"
			metadata: {
				name:      "domain-controller"
				namespace: "system-ingress"
				annotations: "iam.gke.io/gcp-service-account": "domain-controller@augustfengd.iam.gserviceaccount.com"
			}
		},
		{
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "Role"
			metadata: {
				name:      "domain-controller"
				namespace: "system-ingress"
			}
			rules: [{
				apiGroups: ["apps"]
				resources: ["deployments"]
				verbs: ["get"]
			}, {
				apiGroups: ["apps"]
				resources: ["replicasets"]
				verbs: ["list"]
			}, {
				apiGroups: [""]
				resources: ["pods"]
				verbs: ["list"]
			}]
		},
		{
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "RoleBinding"
			metadata: {
				name:      "domain-controller"
				namespace: "system-ingress"
			}
			roleRef: {
				apiGroup: "rbac.authorization.k8s.io"
				kind:     "Role"
				name:     "domain-controller"
			}
			subjects: [{
				kind:      "ServiceAccount"
				name:      "domain-controller"
				namespace: "system-ingress"
			}]
		},
		{
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "ClusterRole"
			metadata: name: "domain-controller"
			rules: [{
				apiGroups: [""]
				resources: ["nodes"]
				verbs: ["get"]
			}]
		},
		{
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "ClusterRoleBinding"
			metadata: name: "domain-controller"
			roleRef: {
				apiGroup: "rbac.authorization.k8s.io"
				kind:     "ClusterRole"
				name:     "domain-controller"
			}
			subjects: [{
				kind:      "ServiceAccount"
				name:      "domain-controller"
				namespace: "system-ingress"
			}]
		},
	]
}

manifests: {
	cronjob:    app.cronjob.manifests
	deployment: app.deployment.manifests
	rbac:       app.rbac.manifests
}
