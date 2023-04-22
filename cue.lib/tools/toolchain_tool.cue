package toolchain

import (
	"tool/exec"
)

command: run: exec.Run & {
	cmd: "docker run -it -v /Users/august.feng/repositories/gh/augustfengd/augustfeng.app:/augustfeng.app --rm ghcr.io/augustfengd/augustfeng.app/toolchain"
}
