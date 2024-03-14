package kubernetes

import (
	rbac "k8s.io/api/rbac/v1"

	"list"
)

#clusterrole: {
	_#apiGroups: "" | "extensions" | "networking.k8s.io" | string // exhaust this disjunction later.

	_#resources: "services" | "endpoints" | "secrets" | "ingresses" | "ingressclasses" | "ingresses/status" | string // exhaust this disjunction later.

	_#verbs: {
		// exhaust this disjunction later
		get:    bool | *false
		list:   bool | *false
		watch:  bool | *false
		update: bool | *false
		create: bool | *false
		delete: bool | *false
		patch:  bool | *false
	}

	#get:    _#verbs & {get:    true}
	#list:   _#verbs & {list:   true}
	#watch:  _#verbs & {watch:  true}
	#update: _#verbs & {update: true}
	#create: _#verbs & {create: true}
	#delete: _#verbs & {delete: true}
	#patch:  _#verbs & {patch:  true}

	name: string
	rules: [_#apiGroups]: [_#resources]: _#verbs

	manifests: [rbac.#ClusterRole & {
		metadata: "name": name

		_rules: [ for apiGroup, resources in rules {
			[ for resource, verbs in resources {
				"apiGroups": [apiGroup]
				"resources": [resource]
				"verbs": {
					let filter = {for verb, it in verbs if it == true {(verb): it}}
					[ for verb, _ in filter {verb}]
				}
			}]
		}]
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
