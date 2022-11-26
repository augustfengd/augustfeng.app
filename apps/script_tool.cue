package scripts

import (
	"github.com/augustfengd/augustfeng.app/tools:git"

	"tool/exec"
	"tool/file"

)

command: blog: {
	root: git.#root
	theme: {
		mkdir: file.MkdirAll & {
			path: "\(root.dir)/apps/blog/themes/hugo-paper"
		}
		install: exec.Run & {
			cmd: ["/bin/sh", "-c", "wget -qO- 'https://github.com/nanxiaobei/hugo-paper/archive/master.tar.gz' | tar xzf - --strip-components=1 -C \(mkdir.path)"]
		}
	}
	serve: exec.Run & {
		cmd: "docker run --rm -it -p 1313:1313 -v \(root.dir)/apps/blog:/src klakegg/hugo server"
	}
}
