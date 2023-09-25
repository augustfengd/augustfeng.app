package ansible

nodes: {
	controlplane: ["192.168.0.254"]
	worker: []
	etcd: []
}

versions: {
	containerd: "1.6.23"
	runc:       "1.1.9"
	cni:        "1.3.0"
	kubernetes: "1.28"
	weave:      "2.8.1"
}
