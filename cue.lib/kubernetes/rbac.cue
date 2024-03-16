package kubernetes

import (
	rbac "k8s.io/api/rbac/v1"

	"list"
)

#clusterrole: {
	_#type: "apiGroups" | "nonResourceURLs"

	_#apiGroups: ["", "extensions", "networking.k8s.io", "apps", "monitoring.coreos.com", "storage.k8s.io", "traefik.io", "traefik.containo.us"]

	_#nonResourceURLs: ["/metrics"]

	_#resources: "services" | "endpoints" | "secrets" | "ingresses" | "ingressclasses" | "ingresses/status" | "nodes" | "nodes/metrics" | "configmaps" | "pods" | string // no benefits in exhausting this list.

	_#verbs: {
		// exhaust this disjunction later
		get:    bool | *false
		list:   bool | *false
		watch:  bool | *false
		update: bool | *false
		create: bool | *false
		delete: bool | *false
		patch:  bool | *false
		'*':    bool | *false
	}

	#get:    _#verbs & {get:    true}
	#list:   _#verbs & {list:   true}
	#watch:  _#verbs & {watch:  true}
	#update: _#verbs & {update: true}
	#create: _#verbs & {create: true}
	#delete: _#verbs & {delete: true}
	#patch:  _#verbs & {patch:  true}
	#all:    _#verbs & {"*":    true}

	name: string
	rules: [or(_#apiGroups)]: [_#resources]: _#verbs

	rules: [or(_#nonResourceURLs)]: _#verbs

	manifests: [rbac.#ClusterRole & {
		metadata: "name": name

		_rulesApiGroups: [ for name, resources in rules if list.Contains(_#apiGroups, name) {
			[ for resource, verbs in resources {
				"apiGroups": [name]
				"resources": [resource]
				"verbs": {
					let filter = {for verb, it in verbs if it == true {(verb): it}}
					[ for verb, _ in filter {verb}]
				}
			}]
		}]
		_rulesNonResourceURLs: [ for name, verbs in rules if list.Contains(_#nonResourceURLs, name) {
			"nonResourceURLs": [name]
			"verbs": {
				let t = {for verb, b in verbs if b == true {(verb): true}}
				[ for verb, _ in t {verb}]
			}
		}]

		_rules: _rulesApiGroups + _rulesNonResourceURLs

		"rules": list.FlattenN(_rules, 1)
	}]
}

#clusterrolebindings: {
	binding: [string]: [{
		name:      string
		namespace: string
	}]

	manifests: [ for role, subjects in binding {
		rbac.#ClusterRoleBinding & {
			metadata: name: role
			roleRef: {
				apiGroup: "rbac.authorization.k8s.io"
				kind:     "ClusterRole"
				name:     role
			}
			"subjects": [ for subject in subjects {
				kind:      "ServiceAccount"
				name:      subject.name
				namespace: subject.namespace
			}]
		}
	}]
}
