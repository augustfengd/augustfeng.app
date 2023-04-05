package kubernetes

import (
	"github.com/augustfengd/augustfeng.app/cloud:kubernetes"
)

_app: {
	deployment: kubernetes.#deployment & {
		image: {
			name: "ghcr.io/augustfengd/augustfeng.app/domain"
		}
		sa: "domain-controller"
	}
	// abstract me later
	rbac: manifests: [
		{
			apiVersion: "v1"
			kind:       "ServiceAccount"
			metadata: {
				name:      "domain-controller"
				namespace: "system-ingress"
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

manifests:
	_app.deployment.manifests +
	_app.rbac.manifests
