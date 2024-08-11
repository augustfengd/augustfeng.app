// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://github.com/traefik/traefik/raw/master/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

package v1alpha1

import "strings"

// TLSStore is the CRD implementation of a Traefik TLS Store.
// For the time being, only the TLSStore named default is
// supported.
// This means that you cannot have two stores that are named
// default in different Kubernetes namespaces.
// More info:
// https://doc.traefik.io/traefik/v3.1/https/tls/#certificates-stores
#TLSStore: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "traefik.io/v1alpha1"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "TLSStore"
	metadata: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace!: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}

	// TLSStoreSpec defines the desired state of a TLSStore.
	spec!: #TLSStoreSpec
}

// TLSStoreSpec defines the desired state of a TLSStore.
#TLSStoreSpec: {
	// Certificates is a list of secret names, each secret holding a
	// key/certificate pair to add to the store.
	certificates?: [...{
		// SecretName is the name of the referenced Kubernetes Secret to
		// specify the certificate details.
		secretName: string
	}]
	defaultCertificate?: {
		// SecretName is the name of the referenced Kubernetes Secret to
		// specify the certificate details.
		secretName: string
	}

	// DefaultGeneratedCert defines the default generated certificate
	// configuration.
	defaultGeneratedCert?: {
		// Domain is the domain definition for the DefaultCertificate.
		domain?: {
			// Main defines the main domain name.
			main?: string

			// SANs defines the subject alternative domain names.
			sans?: [...string]
		}

		// Resolver is the name of the resolver that will be used to issue
		// the DefaultCertificate.
		resolver?: string
	}
}