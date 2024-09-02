package kubernetes

import (
	core "k8s.io/api/core/v1"

	"strings"
	"list"
	"encoding/base64"
)

#pod: {
	image: {
		name: string
		*{
			#TagOrDigest: "tag"
			tag:          string | *"latest"
		} | {
			#TagOrDigest: "digest"
			digest:       string
		}
	}
	command: string | *null
	args: [string]: null | string

	let _name = { let s = strings.Split(image.name, "/"), s[len(s)-1]}
	manifests: [core.#Pod & {
		metadata: {
			name: _name
			labels: "app.kubernetes.io/name": _name
		}
		spec: containers: [{
			"name": _name
			"image": {
				if image.#TagOrDigest == "tag" {strings.Join([image.name, image.tag], ":")}
				if image.#TagOrDigest == "digest" {strings.Join([image.name, image.digest], "@")}
			}
			if command != null {
				"command": [command]
			}
			if args != null {
				"args": list.Concat([[ for k, v in args if v == null {k}], list.FlattenN([ for k, v in args if v != null {[k, v]}], -1)])
			}}]
	}]
}

#secrets: S={
	// kubernetes object name
	[!="manifests"]: {
		#type: core.#enumSecretType | *"Opaque"

		// key
		[k=string]: string
	}

	manifests: [ for n, d in S if n != "manifests" {
		core.#Secret & {
			metadata: name: n
			type: d.#type
			stringData: {for k, v in d {(k): base64.Encode(null, v)}}
		}
	}]
}

#configmaps: S={
	// kubernetes object name
	[!="manifests"]: {
		// key
		[k=string]: string
	}

	manifests: [ for n, d in S if n != "manifests" {
		core.#ConfigMap & {
			metadata: name: n
			data: {for k, v in d {(k): v}}
		}
	}]
}

#serviceaccount: {
	name: string
	manifests: [core.#ServiceAccount & {metadata: "name": name}]
}

#namespace: {
	name: string
	manifests: [core.#Namespace & {metadata: "name": name}]
}
