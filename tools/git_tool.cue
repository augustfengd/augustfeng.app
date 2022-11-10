package git

import (
	"strings"

	"tool/exec"
)

#root: exec.Run & {
	cmd:    "git rev-parse --show-toplevel"
	stdout: string
	dir:    strings.TrimSpace(stdout)
}
