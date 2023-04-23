package secrets

import (
	"strings"
	"tool/exec"
	"tool/file"

	"github.com/augustfengd/augustfeng.app/cue.lib/tools:git"
)

#secrets: {
	root:   git.#root
	path:   string
	secret: file.Glob & {
		glob: root.dir + "/" + path + "/*"
		files: [...string]
	}
	encrypted: [ for _, f in secret.files if strings.HasSuffix(f, ".enc.json") {f}]
	decrypted: [ for _, f in secret.files if !strings.HasSuffix(f, ".enc.json") && !strings.HasSuffix(f, "_tool.cue") && !strings.HasSuffix(f, "secrets.cue") {f}]
	converted: [ for _, f in secret.files if !strings.HasSuffix(f, ".enc.json") && !strings.HasSuffix(f, "_tool.cue") && !strings.HasSuffix(f, "secrets.cue") {strings.Replace(f, ".json", ".cue", -1)}]
}

encrypt: {
	secrets: #secrets
	for _, f in secrets.decrypted {
		(f): exec.Run & {
			cmd: ["sops", "-e", "--output", strings.Replace(f, ".json", ".enc.json", -1), (f)]
			stdout: string
		}
	}
}

decrypt: {
	secrets: #secrets
	for _, f in secrets.encrypted {
		(f): exec.Run & {
			cmd: ["sops", "-d", "--output", strings.Replace(f, ".enc.json", ".json", -1), (f)]
			stdout: string
		}
	}
}

convert: {
	secrets: #secrets
	for _, f in secrets.decrypted {
		(f): exec.Run & {
			cmd: ["cue",
				"import",
				"-p", "secrets",
				"-f",
				"--with-context",
				"-l", "path.Base(filename)",
				(f),
			]
		}
	}
}

updatekeys: {
	secrets: #secrets
	for _, f in secrets.encrypted {
		(f): exec.Run & {
			cmd: ["sops", "updatekeys", "-y", (f)]
			stdout: string
		}
	}
}

command: clean: {
	secrets: #secrets
	for _, f in secrets.decrypted + secrets.converted {
		(f): files: file.RemoveAll & {
			path: (f)
		}
	}
}
