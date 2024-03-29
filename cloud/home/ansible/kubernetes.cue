package ansible

#versions: {
	containerd: string
	runc:       string
	cni:        string
	kubernetes: string
	weave:      string
}

versions: #versions

#configureContainerRuntimePrerequisites: {
	hosts:  "controlplane, worker"
	become: "yes"
	tasks: [{
		name: "/etc/modules-load.d/k8s.conf (touch)"
		file: {
			path:              "/etc/modules-load.d/k8s.conf"
			state:             "touch"
			access_time:       "preserve"
			modification_time: "preserve"
		}
	}, {
		name: "/etc/modules-load.d/k8s.conf (configure)"
		blockinfile: {
			path: "/etc/modules-load.d/k8s.conf"
			block: """
				overlay
				br_netfilter
				"""
		}
	}, {
		name: "load kernel module (overlay)"
		modprobe: {
			name:  "overlay"
			state: "present"
		}
	}, {
		name: "load kernel module (br_netfilter)"
		modprobe: {
			name:  "br_netfilter"
			state: "present"
		}
	}, {
		name: "sysctl (net.ipv4.ip_forward)"
		sysctl: {
			name:        "net.ipv4.ip_forward"
			value:       "1"
			sysctl_file: "/etc/sysctl.d/k8s.conf"
		}
	}, {
		name: "sysctl (net.bridge.bridge-nf-call-iptables)"
		sysctl: {
			name:        "net.bridge.bridge-nf-call-iptables"
			value:       "1"
			sysctl_file: "/etc/sysctl.d/k8s.conf"
		}
	}, {
		name: "sysctl (net.bridge.bridge-nf-call-ip6tables)"
		sysctl: {
			name:        "net.bridge.bridge-nf-call-ip6tables"
			value:       "1"
			sysctl_file: "/etc/sysctl.d/k8s.conf"
		}
	}]
}

#configureContainerRuntime: {
	hosts:  "controlplane, worker"
	become: "yes"
	tasks: [{
		name: "containerd (install)"
		unarchive: {
			src:        "https://github.com/containerd/containerd/releases/download/v\(versions.containerd)/containerd-\(versions.containerd)-linux-amd64.tar.gz"
			dest:       "/usr/local"
			remote_src: "yes"
		}
	}, {
		name: "/etc/containerd (directory)"
		file: {
			path:  "/etc/containerd"
			state: "directory"
		}
	}, {
		// I had installed containerd as part of a docker installation. Be sure to override the existing configuration file!
		name: "containerd (configure)"
		shell: {
			cmd:     "containerd config default | sed 's/^ *//' > config.toml"
			chdir:   "/etc/containerd"
			creates: "config.toml"
		}
	}, {
		name: "containerd (configure)"
		"ini_file": {
			path:    "/etc/containerd/config.toml"
			section: "plugins.\"io.containerd.grpc.v1.cri\".containerd.runtimes.runc.options"
			option:  "SystemdCgroup"
			value:   "true"
		}
	}, {
		name: "runc (install)"
		get_url: {
			url:  "https://github.com/opencontainers/runc/releases/download/v\(versions.runc)/runc.amd64"
			dest: "/usr/local/sbin/runc"
			mode: "755"
		}
	}, {
		name: "/opt/cni/bin (directory)"
		file: {
			path:  "/opt/cni/bin"
			state: "directory"
		}
	}, {
		name: "cni (install)"
		unarchive: {
			src:        "https://github.com/containernetworking/plugins/releases/download/v\(versions.cni)/cni-plugins-linux-amd64-v\(versions.cni).tgz"
			dest:       "/opt/cni/bin"
			remote_src: "yes"
		}
	}, {
		name: "/usr/local/lib/systemd/system (directory)"
		file: {
			path:  "/usr/local/lib/systemd/system"
			state: "directory"
		}
	}, {
		name: "containerd.service (download)"
		get_url: {
			url:  "https://raw.githubusercontent.com/containerd/containerd/main/containerd.service"
			dest: "/usr/local/lib/systemd/system"
		}
	}, {
		name: "containerd.service (start)"
		systemd: {
			state:         "started"
			name:          "containerd"
			daemon_reload: "yes"
		}
	}, {
		name: "disable swap (/etc/fstab)"
		"ansible.posix.mount": {
			path:   "none" // fstab(5)
			fstype: "swap"
			state:  "absent"
		}
	}, {
		name:    "disable swap (command)"
		command: "swapoff -a"
		when:    "ansible_swaptotal_mb > 0"
	}]
}

#configureKubeadmKubeletKubectl: {
	hosts:  "controlplane, worker"
	become: "yes"
	tasks: [{
		name: "signing key (install)"
		get_url: {
			url:  "https://pkgs.k8s.io/core:/stable:/v\(versions.kubernetes)/deb/Release.key"
			dest: "/etc/apt/keyrings/kubernetes-apt-keyring.asc"
		}
	}, {
		name: "signing key (configure)"
		apt_repository: {
			repo:  "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.asc] https://pkgs.k8s.io/core:/stable:/v\(versions.kubernetes)/deb/ /"
			state: "present"
		}
	}, {
		name: "kubeadm, kubelet, kubectl (install)"
		apt: {
			pkg: ["kubeadm", "kubelet", "kubectl"]
			update_cache: "yes"
		}
	}, {
		name: "kubeadm (hold)"
		dpkg_selections: {
			name:      "kubeadm"
			selection: "hold"
		}
	}, {
		name: "kubelet (hold)"
		dpkg_selections: {
			name:      "kubelet"
			selection: "hold"
		}
	}, {
		name: "kubectl (hold)"
		dpkg_selections: {
			name:      "kubectl"
			selection: "hold"
		}
	}]
}

#installKubernetes: {
	hosts:  "controlplane"
	become: "yes"
	tasks: [
		{
			name: "gather service facts"
			service_facts: {}
		},
		{
			name:    "kubeadm init"
			command: "kubeadm init"
			when:    "ansible_facts.services['kubelet.service'].status == 'disabled'" // untested
		}]
}

#installNetworkAddOn: {
	hosts:  "controlplane"
	become: "yes"
	tasks: [{
		name:    "weave net (install)"
		command: "kubectl apply -f https://github.com/weaveworks/weave/releases/download/v\(versions.weave)/weave-daemonset-k8s.yaml"
		when:    "ansible_weave is falsy" // untested
	}]
}

#configureDns: {
	hosts:  "controlplane"
	become: "yes"
	tasks: [{
		name: "NetworkManager.service (configure)"
		"ini_file": {
			path:    "/etc/NetworkManager/NetworkManager.conf"
			section: "main"
			option:  "dns"
			value:   "default"
		}
	}]
}
