package kubernetes

applications: [application=string]: [resource=string]: [object=string]: {
	kind: resource
	metadata: {
		name: object
		// TODO: write an if guard for a default metadata.namespace
	}
}

applications: [application=string]: {
	#name: application
}
