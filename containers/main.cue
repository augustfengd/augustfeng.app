package main

import (
	"dagger.io/dagger"
	"dagger.io/dagger/core"
	"universe.dagger.io/alpine"
	"universe.dagger.io/docker"
	"universe.dagger.io/docker/cli"
)

dagger.#Plan & {
	client: network: "unix:///var/run/docker.sock": connect: dagger.#Socket

	client: commands: sops: {
		name: "sops"
		args: ["-d", "./secrets/gh.enc.json"]
		stdout: dagger.#Secret
	}

	actions: secrets: {
		gh_token: core.#DecodeSecret & {
			input:  client.commands.sops.stdout
			format: "json"
		}
	}

	actions: build: {
		postfix: docker.#Build & {
			steps: [
				alpine.#Build & {
					packages: {
						"bash":    _
						"postfix": _
					}
				},
				docker.#Run & {
					command: {
						name: "apk"
						args: ["add", "vim", "ripgrep", "zsh", "curl", "git"]
						flags: {
							"-U":         true
							"--no-cache": true
						}
					}
				},
				docker.#Run & {
					command: {
						name: "sh"
						args: ["-c", "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended"]
					}
				},
				docker.#Run & {
					command: {
						name: "postconf"
						#s:   "maillog_file = /dev/stdout"
						args: ["-e", #s]
					}
				},
				docker.#Run & {
					command: {
						name: "postconf"
						#s:   "mydestination = augustfeng.app"
						args: ["-e", #s]
					}
				},
				docker.#Set & {
					config: {
						label: "org.opencontainers.image.source": "https://github.com/augustfengd/augustfeng.app"
						cmd: ["postfix", "start-fg"]
					}
				},
			]
		}
	}

	actions: load: {
		for i, _ in actions.build {
			(i): cli.#Load & {
				image: actions.build[i].output
				host:  client.network."unix:///var/run/docker.sock".connect
				tag:   (i)
			}
		}
	}

	actions: push: {
		for i, _ in actions.build {
			(i): docker.#Push & {
				image: actions.build[i].output
				dest:  "ghcr.io/augustfengd/\(i)"
				auth: {
					username: "augustfengd" // NOTE: would like to reference secrets in ordinary fields that aren't `dagger.#Secret`.
					secret:   actions.secrets.gh_token.output.token.contents
				}
			}
		}
	}
}
