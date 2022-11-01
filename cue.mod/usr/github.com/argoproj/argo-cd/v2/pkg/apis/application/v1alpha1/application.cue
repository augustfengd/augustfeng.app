package v1alpha1

#Application: {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"

	// sensible defaults
	metadata: namespace: string | *"argocd"
	spec: {
		destination: {
			server: string | *"https://kubernetes.default.svc"
		}
		syncPolicy: {
			syncOptions: [...string] | *["CreateNamespace=true"]
			automated: {}
		}
	}
}

// NOTE: missing from imported definition
#ApplicationDestination: {server: string, namespace: string}
