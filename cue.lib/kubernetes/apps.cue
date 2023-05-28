package kubernetes

import (
	core "k8s.io/api/core/v1"
	apps "k8s.io/api/apps/v1"

	"struct"
	"strings"
	"list"
)

#deployment: {
	name: string | *{ let s = strings.Split(image.name, "/"), s[len(s)-1]}
	annotations: [string]: string
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
	env: [string]: {// description: secret sources exclusively from secret or value.
			secret: null
			value:  string | *null
	} | {
		secret: struct.MaxFields(1) & struct.MinFields(1)
		secret: {
			// kubernetes object name
			[string]: {
				// secret key reference
				string
			}
		}
		value: null
	}
	command: string | *null
	args: [string]: string | *null
	X=expose: ports: [string]: number
	expose: protocol: {for a, b in X.ports {(a): "UDP" | *"TCP"}} // NOTE: map each port to a protocol and provide an interface for override.
	mount: {
		secret: {}
		configmap: {}
		emptydir: {}
		[=~"secret|configmap|emptydir|pvc"]: {
			// kubernetes object name
			[string]: {
				// mount path
				[string]: {
					// subpath
					string | *null
				}
			}
		}
	}
	sa: string | *null

	manifests: [
		apps.#Deployment & {
			X=metadata: {
				"name": name
				"labels": "app.kubernetes.io/name": name
			}
			spec: selector: matchLabels: X.labels
			spec: template: spec: containers: [{
				"image": {
					if image.tag != _|_ {strings.Join([image.name, image.tag], ":")}
					if image.digest != _|_ {strings.Join([image.name, image.digest], "@")}
				}
				"name": name
				"env": [ for k, v in _env_ {name: k, v}]
				_env_: {
					for n, c in env {
						if c.value != null {
							(n): value: c.value
						}
						if c.secret != null {
							(n): valueFrom: secretKeyRef: {
								for n, c in c.secret {
									name: n
									key:  c
								}
							}
						}
					}
				}
				if command != null {
					"command": [command]
				}
				if args != null {
					"args": [ for k, v in args if v == null {k}] + list.FlattenN([ for k, v in args if v != null {[k, v]}], -1)
				}
				"volumeMounts": [ for mp, c in _volumeMounts_ {mountPath: mp, c}]
				_volumeMounts_: {
					for s, c in {mount.secret, mount.configmap, mount.emptydir} {
						for mp, sp in c {
							(mp): {
								name: (s)
								if sp != null {
									subPath: (sp)
								}

							}
						}
					}
				}
			}]
			spec: template: spec: volumes:    [ for s, _ in mount.emptydir {name: s, emptyDir: {}}] + [ for s, _ in mount.secret {name: s, secret: secretName: s}] + [ for s, _ in mount.configmap {name: s, configMap: name: s}]
			spec: template: metadata: labels: X.labels
			spec: template: spec: {if sa != null {serviceAccountName: sa}}
		},

		if len(expose.ports) > 0 {
			core.#Service & {
				metadata: {
					"name": name
					labels: "app.kubernetes.io/name": name
				}
				spec: ports: [ for n, p in expose.ports {name: n, port: p, targetPort: p, protocol: expose.protocol[n]}]
				spec: selector: manifests[0].metadata.labels
			}
		},
	]
}
