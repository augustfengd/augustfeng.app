package apps

import (
	"github.com/augustfengd/augustfeng.app/tools:git"

	"tool/exec"
)

command: blog: {
	root:  git.#root
	theme: exec.Run & {
		let theme_dir = (root.dir) + "/apps/blog/themes/hugo-paper"
		cmd: ["sh", "-c", "mkdir -p \(theme_dir); wget -qO- 'https://github.com/nanxiaobei/hugo-paper/archive/master.tar.gz' | tar xzf - --strip-components=1 -C \(theme_dir)"]
	}
	serve: exec.Run & {
		$after: theme.$done
		cmd:    "docker run --rm -it -p 1313:1313 -v \(root.dir)/apps/blog:/src ghcr.io/augustfengd/augustfeng.app/blog"
	}
}
