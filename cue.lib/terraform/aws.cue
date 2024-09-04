package terraform

lib: aws: {
	resource: {}

	terraform: required_providers: {
		aws: {
			source:  "hashicorp/aws"
			version: "5.65.0"
		}
	}

	provider: aws: {}
}
