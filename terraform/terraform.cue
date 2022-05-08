package terraform

import (
	"github.com/augustfengd/augustfeng.app:config"
	"encoding/yaml"
)

resource: #resource & {
	digitalocean_project: "augustfeng-app": {
		name: "augustfeng.app"
		resources: [ for droplet in resource.digitalocean_droplet {"${digitalocean_droplet.\(droplet.name).urn}"}]
	}

	digitalocean_ssh_key: augustfengd: {
		name:       "augustfeng-app-augustfengd"
		public_key: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8uyj9CjbNOSW/fkR2sAcif52NwDv/2Cu9BTRVHO0bO au.fengster@gmail.com"
	}

	digitalocean_droplet: jojo: {
		image:  "ubuntu-22-04-x64"
		region: "tor1"
		size:   "s-1vcpu-1gb"
		ssh_keys: [ for r, _ in resource.digitalocean_ssh_key {"${digitalocean_ssh_key.\(r).fingerprint}"}]
		_cloud_init: {
			packages: [
				"vim",
			]
			runcmd: [
				"curl -sfL https://get.k3s.io | sh -",
			]
		}
		user_data: "#cloud-config\n" + yaml.Marshal(_cloud_init)
	}

	namecheap_domain_records: "augustfeng-app": {
		domain: "augustfeng.app"
		mode:   "OVERWRITE"
		for r, _ in resource.digitalocean_droplet {
			record: {
				hostname: "@"
				type:     "A"
				address:  "${digitalocean_droplet.\(r).ipv4_address}"
			}
		}
	}
}

terraform: {
	required_providers: {
		digitalocean: {
			source:  "digitalocean/digitalocean"
			version: "~> 2.0"
		}
		namecheap: {
			source:  "namecheap/namecheap"
			version: ">= 2.0.0"
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

#resource: {
	[=~"^digitalocean"]: [n=string]: {
		name: string | *n
		...
	}
	...
}
