package ansible

#configureContainerRuntimePrerequisites: {}
#configureContainerRuntime: {}
#configureKubeadmKubeletKubectl: {}
#installKubernetes: {}
#installNetworkAddOn: {}
#configureDns: {}

output: playbooks: {
	installKubernetes: [
		#configureDns,
		#configureContainerRuntimePrerequisites,
		#configureContainerRuntime,
		#configureKubeadmKubeletKubectl,
		#installKubernetes,
		#installNetworkAddOn,
		// ssh onto controlplane and run kubeadm commands manually: "kubeadm init --pod-network-cidr=10.244.0.0/16"
	]
}
