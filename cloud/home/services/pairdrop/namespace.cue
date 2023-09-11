package pairdrop

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

namespace:
	kubernetes.#namespace & {
		name: "pairdrop"
	}
