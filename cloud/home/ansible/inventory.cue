package ansible

#nodes: {
	controlplane: [...string]
	worker: [...string]
	etcd: [...string]
}

nodes: #nodes

output: inventory: {
	controlplane: hosts: {
		for i, ip in nodes.controlplane {
			"controlplane-\(i)": ansible_host: ip
			"controlplane-\(i)": ansible_user: "augustfengd"
		}
	}

	worker: hosts: {
		for i, ip in nodes.worker {
			"worker-\(i)": ansible_host: ip
			"worker-\(i)": ansible_user: "augustfengd"
		}
	}

	etcd: hosts: {
		for i, ip in nodes.worker {
			"etcd-\(i)": ansible_host: ip
			"etcd-\(i)": ansible_user: "augustfengd"
		}
	}
}
