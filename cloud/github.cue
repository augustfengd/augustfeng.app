package terraform

lib: github: {

	_github: {
		secrets: [string]: string
	}

	resource: {
		for secret, value in _github.secrets {
			"github_actions_secret": (secret): {
				repository:      "augustfeng.app"
				secret_name:     (secret)
				plaintext_value: (value)
			}
		}
	}

	terraform: required_providers: {
		github: {
			source:  "integrations/github"
			version: "5.7.0"
		}
	}
}
