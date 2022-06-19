package kubernetes

[application=string]: {
	#name: application
	[resource=string]: [object=string]: {
		kind: resource
		metadata: {
			name: object
			// TODO: write an if guard for a default metadata.namespace
		}
	}
}
