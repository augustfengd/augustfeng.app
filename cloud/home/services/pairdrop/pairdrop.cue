package pairdrop

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

deployment:
	kubernetes.#deployment & {
		image: name: "linuxserver/pairdrop"
		expose: ports: "web": 3000
	}
