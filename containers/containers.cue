package containers

import (
	"strings"
	"dagger.io/dagger"
	"dagger.io/dagger/core"
	"universe.dagger.io/alpine"
	"universe.dagger.io/docker"
	"universe.dagger.io/docker/cli"
)

dagger.#Plan & {
	client: network: "unix:///var/run/docker.sock": connect: dagger.#Socket
	client: commands: {
		gh_token: {
			name: "sops"
			args: ["-d", "./secrets/gh.enc.json"]
			stdout: dagger.#Secret
		}
	}

	actions: secrets: {
		gh_token: core.#DecodeSecret & {
			input:  client.commands.gh_token.stdout
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

		toolchain: {
			_cue: core.#Pull & {source: "cuelang/cue:0.4.3"}
			_jsonnet: {
				archive: core.#HTTPFetch & {
					source: "https://github.com/google/go-jsonnet/releases/download/v0.19.1/go-jsonnet_0.19.1_Linux_x86_64.tar.gz"
					dest:   "go-jsonnet_0.19.1_Linux_x86_64.tar.gz"
				}
				files: {
					runtime: core.#Pull & {source: "alpine"}
					extract: core.#Exec & {
						input: runtime.output
						mounts: "go-jsonnet": {
							contents: archive.output
							dest:     "/mnt/go-jsonnet"
						}
						workdir: "/go-jsonnet"
						args: ["tar", "xf", "/mnt/go-jsonnet/go-jsonnet_0.19.1_Linux_x86_64.tar.gz"]
					}
					output: extract.output
				}
				output: files.output
			}
			_age: {
				archive: core.#HTTPFetch & {
					source: "https://github.com/FiloSottile/age/releases/download/v1.0.0/age-v1.0.0-linux-amd64.tar.gz"
					dest:   "age-v1.0.0-linux-amd64.tar.gz"
				}
				files: {
					runtime: core.#Pull & {source: "alpine"}
					extract: core.#Exec & {
						input: runtime.output
						mounts: "age": {
							contents: archive.output
							dest:     "/mnt/age"
						}
						workdir: "/"
						args: ["tar", "xf", "/mnt/age/age-v1.0.0-linux-amd64.tar.gz"]
					}
					output: extract.output
				}
				output: files.output
			}
			_terraform: core.#Pull & {source: "hashicorp/terraform:1.3.0"}
			_sops:      core.#Pull & {source: "mozilla/sops:v3.7.3-alpine"}
			_kubectl:   core.#Pull & {source: "bitnami/kubectl"}
			_gcloud: {
				archive: core.#HTTPFetch & {
					source: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-403.0.0-linux-x86_64.tar.gz"
					dest:   "google-cloud-cli-403.0.0-linux-x86_64.tar.gz"
				}
				files: {
					runtime: core.#Pull & {source: "alpine"}
					extract: core.#Exec & {
						input: runtime.output
						mounts: "google-cloud-sdk": {
							contents: archive.output
							dest:     "/mnt/google-cloud-sdk"
						}
						workdir: "/"
						args: ["tar", "xf", "/mnt/google-cloud-sdk/google-cloud-cli-403.0.0-linux-x86_64.tar.gz"]
					}
					output: extract.output
				}
				output: files.output
			}

			docker.#Build & {
				steps: [
					alpine.#Build,
					docker.#Run & {
						command: {
							name: "apk"
							args: ["add"] + ["make", "vim", "ripgrep", "zsh", "curl", "git", "gpg", "gpg-agent", "python3"]
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
							let #plugins = strings.Join(["git", "z", "terraform", "gcloud"], " ")
							name: "sed"
							args: ["-i", "s/^plugins=(.*)/plugins=(\(#plugins))/", "/root/.zshrc"]
						}
					},
					docker.#Copy & {
						contents: _cue.output
						source:   "/usr/bin/cue"
						dest:     "/usr/bin/cue"
					},
					docker.#Copy & {
						contents: _jsonnet.output
						source:   "/go-jsonnet/jsonnet"
						dest:     "/usr/local/bin/jsonnet"
					},
					docker.#Copy & {
						contents: _age.output
						source:   "/age/age"
						dest:     "/usr/local/bin/age"
					},
					docker.#Copy & {
						contents: _terraform.output
						source:   "/bin/terraform"
						dest:     "/bin/terraform"
					},
					docker.#Copy & {
						contents: _sops.output
						source:   "/usr/local/bin/sops"
						dest:     "/usr/local/bin/sops"
					},
					docker.#Copy & {
						contents: _kubectl.output
						source:   "/opt/bitnami/kubectl/bin/kubectl"
						dest:     "/usr/local/bin/kubectl"
					},
					docker.#Copy & {
						contents: _gcloud.output
						source:   "/google-cloud-sdk"
						dest:     "/opt/google-cloud-sdk"
					},
					docker.#Run & {
						command: {
							name: "/opt/google-cloud-sdk/bin/gcloud"
							args: ["components", "install", "gke-gcloud-auth-plugin", "--quiet", "--no-user-output-enabled"]
						}
					},
					docker.#Set & {
						config: {
							label: "org.opencontainers.image.source": "https://github.com/augustfengd/augustfeng.app"
							cmd: ["zsh"]
						}
					},
				]
			}
		}
	}

	actions: load: {
		for i, _ in actions.build {
			(i): cli.#Load & {
				image: actions.build[i].output
				host:  client.network."unix:///var/run/docker.sock".connect
				tag:   "ghcr.io/augustfengd/\(i)"
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
