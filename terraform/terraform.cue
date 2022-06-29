package terraform

import (
	"github.com/augustfengd/augustfeng.app/terraform:config"
	"encoding/yaml"
	"strings"
)

resource: {
	digitalocean_project: "augustfeng-app": {
		name: "augustfeng.app"
		resources: [ for droplet in digitalocean_droplet {"${digitalocean_droplet.\(droplet.#name).urn}"}]
	}

	digitalocean_ssh_key: {
		augustfengd: {
			name:       "augustfeng-app-augustfengd"
			public_key: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8uyj9CjbNOSW/fkR2sAcif52NwDv/2Cu9BTRVHO0bO au.fengster@gmail.com"
		}
		terraform: {
			name:       "augustfeng-app-terraform"
			public_key: "${tls_private_key.terraform.public_key_openssh}"
		}
	}

	let #kubernetes_cluster = [ #k3s_server & {#name: "k3s-server"}, #k3s_agent & {#name: "k3s-agent-0"}] & #k3s_cluster
	digitalocean_droplet: #kubernetes_cluster + []

	// FIXME: doesn't run correctly if cluster is provisioned with only a server.
	null_resource: "k3s-prune-nodes": {
		triggers: {
			nodes: strings.Join([ for droplet in digitalocean_droplet if droplet.#name =~ "k3s-(server|agent)" {"${digitalocean_droplet.\(droplet.#name).name}"}], "\n")
		}
		provisioner: "remote-exec": {
			connection: {
				type:        "ssh"
				user:        "root"
				private_key: "${tls_private_key.terraform.private_key_openssh}"
				host:        "${digitalocean_droplet.k3s-server.ipv4_address}"
			}
			inline: [
				"kubectl get nodes -oname | grep -v \"${self.triggers.nodes}\" | xargs --no-run-if-empty kubectl delete",
			]
		}
	}

	random_password: "k3s_token": {
		length:  30
		special: false
	}

	tls_private_key: terraform: {
		algorithm: "ED25519"
	}

	namecheap_domain_records: "augustfeng-app": {
		domain: "augustfeng.app"

		record: [
			for droplet in resource.digitalocean_droplet {
				hostname: "@"
				type:     "A"
				address:  "${digitalocean_droplet.\(droplet.#name).ipv4_address}"
			},
			for droplet in resource.digitalocean_droplet {
				let #reverse = {
					arr: [...]
					out: [ for i, w in arr {arr[len(arr)-i-1]}]
				}

				// e.g: k3s-agent-0 -> 0.agent.k3s
				hostname: strings.Join((#reverse & {arr: strings.Split(droplet.#name, "-")}).out, ".")
				type:     "A"
				address:  "${digitalocean_droplet.\(droplet.#name).ipv4_address}"
			},
		] + [
			// HACK: use wildcard subdomain because external-dns does not support namecheap provider. https://github.com/kubernetes-sigs/external-dns/issues/2069
			for droplet in resource.digitalocean_droplet {
				hostname: "*"
				type:     "A"
				address:  "${digitalocean_droplet.\(droplet.#name).ipv4_address}"
			},
		]
	}

	null_resource: "ssh-known-hosts-resources-reset": {
		let augustfeng_app_dns = namecheap_domain_records["augustfeng-app"]
		#hostnames: [ for record in augustfeng_app_dns.record if record.hostname != "@" {strings.Join([(record.hostname), (augustfeng_app_dns.domain)], ".")}]
		triggers: {
			hostnames: strings.Join(#hostnames, "\n")
		}
		provisioner: "local-exec": [
			for hostname in #hostnames {
				// TODO: don't clear hosts if it's key is still valid.
				command: "ssh-keygen -f ~/.ssh/known_hosts -R \"\(hostname)\""
			},
		]
	}
}

output: {
	for droplet in resource.digitalocean_droplet {
		"\(droplet.#name)-ip": {
			value: "${digitalocean_droplet.\(droplet.#name).ipv4_address}"
		}
	}
}

terraform: {
	required_providers: {
		digitalocean: {
			source:  "digitalocean/digitalocean"
			version: "2.20.0"
		}
		namecheap: {
			source:  "namecheap/namecheap"
			version: "2.1.0"
		}
		tls: {
			source:  "hashicorp/tls"
			version: "3.4.0"
		}
		random: {
			source:  "hashicorp/random"
			version: "3.2.0"
		}
		"null": {
			source:  "hashicorp/null"
			version: "3.1.1"
		}
	}
}

terraform: {
	cloud: {
		organization: config.terraform.workspace.organization
		hostname:     config.terraform.workspace.hostname
		workspaces: {
			name: config.terraform.workspace.name
		}
	}
}

#k3s_cluster: [#k3s_server, ...#k3s_agent] | []

#k3s_server: {
	#name: =~"^k3s-server$"
	(#name): {
		#k3s_node & {name: #name}
		_cloud_init: {
			runcmd: [
				"sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended",
				"curl -sfL https://get.k3s.io | K3S_TOKEN='${random_password.k3s_token.result}' sh -",
			]
		}
	}
}

#k3s_agent: {
	#name: =~"^k3s-agent-[0-9]+$"
	(#name): {
		#k3s_node & {name: #name}
		_cloud_init: {
			runcmd: [
				"sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended",
				"curl -sfL https://get.k3s.io | K3S_URL='https://${digitalocean_droplet.k3s-server.ipv4_address}:6443' K3S_TOKEN='${random_password.k3s_token.result}' sh -",
			]
		}
	}
}

#k3s_node: {
	name:   string
	image:  "ubuntu-22-04-x64"
	region: "tor1"
	size:   "s-1vcpu-1gb"
	_cloud_init: {
		packages: ["zsh"]
	}
	user_data: "#cloud-config\n" + yaml.Marshal(_cloud_init)
	ssh_keys: [ for r, _ in resource.digitalocean_ssh_key {"${digitalocean_ssh_key.\(r).fingerprint}"}]
}
