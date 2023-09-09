package syncthing

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

deployment:
	kubernetes.#deployment & {
		image: {
			name: "syncthing/syncthing"
			tag:  "1.24"
		}
		expose: {
			ports: "web":       8384
			ports: "tcp":       22000
			ports: "quic":      22000
			ports: "discovery": 21027
		}
		expose: protocol: {
			"quic":      "UDP"
			"discovery": "UDP"
		}
	} & {manifests: [{
		spec: template: spec: containers: [{volumeMounts: [{mountPath: "/var/syncthing/Sync", name: "sync"}, {mountPath: "/var/syncthing/config", name: "config"}]}]
		spec: template: spec: volumes: [{name: "sync", hostPath: path: "/home/augustfengd/Sync"}, {name: "config", hostPath: path: "/home/augustfengd/.config/syncthing"}]}, {}]}
