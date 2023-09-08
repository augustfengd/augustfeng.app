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
	}
