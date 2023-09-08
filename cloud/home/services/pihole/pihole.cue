package pihole

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

deployment:
	kubernetes.#deployment & {
		image: name: "pihole/pihole"
		expose: {
			ports: "web":    80
			ports: "domain": 53
		}
		expose: protocol: "domain": "UDP"
		env: WEBPASSWORD: value:    ""
	}
