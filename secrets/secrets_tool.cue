package secrets

import (
	"tool/exec"
	"tool/file"
	"strings"
	"list"
)

command: encrypt: {
	s: #secrets
	for _, f in s.decrypted {
		(f): exec.Run & {
			cmd: ["sops",
				"--output", strings.Replace(f, ".json", ".enc.json", -1),
				"-e", (f)]
		}
	}
}

command: decrypt: {
	s: #secrets
	for _, f in s.encrypted {
		(f): exec.Run & {
			cmd: ["sops",
				"--output", strings.Replace(f, ".enc.json", ".json", -1),
				"-d", (f)]
		}
	}
}

command: convert: {
	s: #secrets
	for _, f in s.decrypted {
		(f): exec.Run & {
			cmd: [
				"cue",
				"import",
				"-p", "secrets",
				"-f",
				"--with-context", "-l", "path.Base(filename)", (f),
			]}
	}
}

command: clean: {
	s: #secrets
	for f in s.decrypted + s.converted {
		(f): file.RemoveAll & {
			path: (f)
		}
	}
}

#secrets: X=file.Glob & {
	glob: "*"
	encrypted: [ for f in X.files if strings.HasSuffix(f, ".enc.json") {f}]
	decrypted: [ for f in X.files if strings.HasSuffix(f, ".json") && !strings.HasSuffix(f, "enc.json") {f}]
	converted: [ for f in X.files if strings.HasSuffix(f, "cue") && list.Contains(decrypted, strings.Replace(f, ".cue", ".json", -1)) {f}]
}
