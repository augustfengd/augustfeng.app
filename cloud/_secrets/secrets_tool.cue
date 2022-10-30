package secrets

import (
	"tool/exec"
	"tool/file"
	"strings"
)

command: decrypt: {
	s: file.Glob & {
		glob: "*.enc.json"
	}
	for _, f in s.files {
		(f): exec.Run & {
			cmd: ["sops",
				"--output", strings.Replace(f, ".enc.json", ".json", -1),
				"-d", (f)]
		}
	}
}

command: convert: {
	s: file.Glob & {
		glob: "*.enc.json"
	}
	for _, f in s.files {
		(f): exec.Run & {
			cmd: [
				"cue",
				"import",
				"-p", "secrets",
				"-f",
				"--with-context", "-l", "path.Base(filename)", strings.Replace(f, ".enc.json", ".json", -1),
			]
		}
	}
}

command: updatekeys: {
	s: file.Glob & {
		glob: "*.enc.json"
	}
	for _, f in s.files {
		(f): exec.Run & {
			cmd: [
				"sops",
				"updatekeys",
				"-y",
				(f),
			]
		}
	}
}

command: clean: {
	s: file.Glob & {
		glob: "*.enc.json"
	}
	for _, f in s.files {
		(strings.Replace(f, ".enc.json", ".json", -1)): file.RemoveAll & {
			path: (strings.Replace(f, ".enc.json", ".json", -1))
		}
		(strings.Replace(f, ".enc.json", ".cue", -1)): file.RemoveAll & {
			path: (strings.Replace(f, ".enc.json", ".cue", -1))
		}
	}
}
