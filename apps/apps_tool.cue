package apps

import (
	"github.com/augustfengd/augustfeng.app/tools:git"

	"tool/exec"
)

command: blog: {
	root:  git.#root
	serve: exec.Run & {
		cmd: "docker run --rm -it -p 1313:1313 -v \(root.dir)/apps/blog:/src ghcr.io/augustfengd/augustfeng.app/blog"
	}
}
