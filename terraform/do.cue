package do

import (
	"encoding/yaml"
	"strings"
)

#c: {
	k3s: {
		server_pool: [_#k3s_server & {name: "k3s-server"}]
		agent_pool: [..._#k3s_agent]
	}
}

resource: {
	digitalocean_project: "augustfeng-app": {
		name: "augustfeng.app"
		resources: [ for droplet in digitalocean_droplet {"${digitalocean_droplet.\(droplet.name).urn}"}]
	}

	digitalocean_ssh_key: {
		augustfengd: {
			name:       "augustfeng-app-augustfengd"
			public_key: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8uyj9CjbNOSW/fkR2sAcif52NwDv/2Cu9BTRVHO0bO augustfengd"
		}
		terraform: {
			name:       "augustfeng-app-terraform"
			public_key: "${tls_private_key.terraform.public_key_openssh}"
		}
	}

	digitalocean_droplet: {for node in (#c.k3s.server_pool + #c.k3s.agent_pool) {(node.name): node}}

	// FIXME: doesn't run correctly if cluster is provisioned with only a server.
	null_resource: "k3s-prune-nodes": {
		triggers: {
			nodes: strings.Join([ for droplet in digitalocean_droplet if droplet.name =~ "k3s-(server|agent)" {"${digitalocean_droplet.\(droplet.name).name}"}], "\n")
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
}

terraform: required_providers: {
	digitalocean: {
		source:  "digitalocean/digitalocean"
		version: "2.20.0"
	}
	_namecheap: {
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

_#k3s_server: {
	_#k3s_node & {name: =~"k3s-server"}
	size: "s-1vcpu-1gb"
	_cloud_init: {
		runcmd: [
			"sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended",
			"curl -sfL https://get.k3s.io | K3S_TOKEN='${random_password.k3s_token.result}' sh -",
		]
	}
}

_#k3s_agent: {
	_#k3s_node & {name: =~"k3s-agent-[0-9]+"}
	_cloud_init: {
		runcmd: [
			"sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended",
			"curl -sfL https://get.k3s.io | K3S_URL='https://${digitalocean_droplet.k3s-server.ipv4_address}:6443' K3S_TOKEN='${random_password.k3s_token.result}' sh -",
		]
	}
}

_#k3s_node: {
	name:   string
	image:  "ubuntu-22-04-x64"
	region: "nyc1"
	size:   string | *"s-1vcpu-512mb-10gb" | "s-1vcpu-1gb"
	_cloud_init: {
		packages: ["zsh"]
	}
	user_data: "#cloud-config\n" + yaml.Marshal(_cloud_init)
	ssh_keys: [ for r, _ in resource.digitalocean_ssh_key {"${digitalocean_ssh_key.\(r).fingerprint}"}]
}
