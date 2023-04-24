package sleep

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

sleep: kubernetes.#pod & {image: name: "augustfengd/augustfeng.app/sleep"}
