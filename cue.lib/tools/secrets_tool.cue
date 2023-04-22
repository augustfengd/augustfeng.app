package secrets

import (
	"strings"
	"tool/exec"
	"tool/file"
)

#secrets: file.Glob & {
	glob: "*"
	files: [...string]
	encrypted: [ for _, f in files if strings.HasSuffix(f, ".enc.json") {f}]
	decrypted: [ for _, f in files if !strings.HasSuffix(f, ".enc.json") {f}]
	converted: [ for _, f in files if !strings.HasSuffix(f, ".enc.json") {strings.Replace(f, ".json", ".cue", -1)}]
}

command: encrypt: {
	secrets: #secrets
	for _, f in secrets.decrypted {
		(f): exec.Run & {
			cmd: ["sops", "-e", "--output", strings.Replace(f, ".json", ".enc.json", -1), (f)]
			stdout: string
		}
	}
}

command: decrypt: {
	secrets: #secrets
	for _, f in secrets.encrypted {
		(f): exec.Run & {
			cmd: ["sops", "-d", "--output", strings.Replace(f, ".enc.json", ".json", -1), (f)]
			stdout: string
		}
	}
}

command: convert: {
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

command: updatekeys: {
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
		"\(f)-cue": file.RemoveAll & {
			path: strings.Replace(f, ".json", ".cue", -1)
		}
	}
}
