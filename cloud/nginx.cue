package kubernetes

components: nginx: {
	image: {
		name: "nginx"
		tag:  string | *"latest"
	}
	expose: ports: http: 8080

	// NOTE: demonstrating the interface for creating UDP port mappings in
	// kubernetes services.
	expose: ports: foobar:    1234
	expose: protocol: foobar: "UDP"
}
