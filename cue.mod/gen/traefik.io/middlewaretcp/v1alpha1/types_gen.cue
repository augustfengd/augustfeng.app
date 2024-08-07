// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://github.com/traefik/traefik/raw/master/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

package v1alpha1

import "strings"

// MiddlewareTCP is the CRD implementation of a Traefik TCP
// middleware.
// More info:
// https://doc.traefik.io/traefik/v3.1/middlewares/overview/
#MiddlewareTCP: {
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
	kind: "MiddlewareTCP"
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

	// MiddlewareTCPSpec defines the desired state of a MiddlewareTCP.
	spec!: #MiddlewareTCPSpec
}

// MiddlewareTCPSpec defines the desired state of a MiddlewareTCP.
#MiddlewareTCPSpec: {
	inFlightConn?: {
		// Amount defines the maximum amount of allowed simultaneous
		// connections.
		// The middleware closes the connection if there are already
		// amount connections opened.
		amount?: int
	}
	ipAllowList?: {
		// SourceRange defines the allowed IPs (or ranges of allowed IPs
		// by using CIDR notation).
		sourceRange?: [...string]
	}
	ipWhiteList?: {
		// SourceRange defines the allowed IPs (or ranges of allowed IPs
		// by using CIDR notation).
		sourceRange?: [...string]
	}
}
