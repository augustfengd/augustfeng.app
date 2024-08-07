// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://github.com/traefik/traefik/raw/master/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

package v1alpha1

import "strings"

// IngressRouteTCP is the CRD implementation of a Traefik TCP
// Router.
#IngressRouteTCP: {
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
	kind: "IngressRouteTCP"
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

	// IngressRouteTCPSpec defines the desired state of
	// IngressRouteTCP.
	spec!: #IngressRouteTCPSpec
}

// IngressRouteTCPSpec defines the desired state of
// IngressRouteTCP.
#IngressRouteTCPSpec: {
	// EntryPoints defines the list of entry point names to bind to.
	// Entry points have to be configured in the static configuration.
	// More info:
	// https://doc.traefik.io/traefik/v3.1/routing/entrypoints/
	// Default: all.
	entryPoints?: [...string]

	// Routes defines the list of routes.
	routes: [...{
		// Match defines the router's rule.
		// More info:
		// https://doc.traefik.io/traefik/v3.1/routing/routers/#rule_1
		match: string

		// Middlewares defines the list of references to MiddlewareTCP
		// resources.
		middlewares?: [...{
			// Name defines the name of the referenced Traefik resource.
			name: string

			// Namespace defines the namespace of the referenced Traefik
			// resource.
			namespace?: string
		}]

		// Priority defines the router's priority.
		// More info:
		// https://doc.traefik.io/traefik/v3.1/routing/routers/#priority_1
		priority?: int

		// Services defines the list of TCP services.
		services?: [...{
			// Name defines the name of the referenced Kubernetes Service.
			name: string

			// Namespace defines the namespace of the referenced Kubernetes
			// Service.
			namespace?: string

			// NativeLB controls, when creating the load-balancer,
			// whether the LB's children are directly the pods IPs or if the
			// only child is the Kubernetes Service clusterIP.
			// The Kubernetes Service itself does load-balance to the pods.
			// By default, NativeLB is false.
			nativeLB?: bool

			// NodePortLB controls, when creating the load-balancer,
			// whether the LB's children are directly the nodes internal IPs
			// using the nodePort when the service type is NodePort.
			// It allows services to be reachable when Traefik runs externally
			// from the Kubernetes cluster but within the same network of the
			// nodes.
			// By default, NodePortLB is false.
			nodePortLB?: bool

			// Port defines the port of a Kubernetes Service.
			// This can be a reference to a named port.
			port: (int | string) & {
				string
			}
			proxyProtocol?: {
				// Version defines the PROXY Protocol version to use.
				version?: int
			}

			// ServersTransport defines the name of ServersTransportTCP
			// resource to use.
			// It allows to configure the transport between Traefik and your
			// servers.
			// Can only be used on a Kubernetes Service.
			serversTransport?: string

			// TerminationDelay defines the deadline that the proxy sets,
			// after one of its connected peers indicates
			// it has closed the writing capability of its connection, to
			// close the reading capability as well,
			// hence fully terminating the connection.
			// It is a duration in milliseconds, defaulting to 100.
			// A negative value means an infinite deadline (i.e. the reading
			// capability is never closed).
			// Deprecated: TerminationDelay is not supported APIVersion
			// traefik.io/v1, please use ServersTransport to configure the
			// TerminationDelay instead.
			terminationDelay?: int

			// TLS determines whether to use TLS when dialing with the
			// backend.
			tls?: bool

			// Weight defines the weight used when balancing requests between
			// multiple Kubernetes Service.
			weight?: int
		}]

		// Syntax defines the router's rule syntax.
		// More info:
		// https://doc.traefik.io/traefik/v3.1/routing/routers/#rulesyntax_1
		syntax?: string
	}]

	// TLS defines the TLS configuration on a layer 4 / TCP Route.
	// More info:
	// https://doc.traefik.io/traefik/v3.1/routing/routers/#tls_1
	tls?: {
		// CertResolver defines the name of the certificate resolver to
		// use.
		// Cert resolvers have to be configured in the static
		// configuration.
		// More info:
		// https://doc.traefik.io/traefik/v3.1/https/acme/#certificate-resolvers
		certResolver?: string

		// Domains defines the list of domains that will be used to issue
		// certificates.
		// More info:
		// https://doc.traefik.io/traefik/v3.1/routing/routers/#domains
		domains?: [...{
			// Main defines the main domain name.
			main?: string

			// SANs defines the subject alternative domain names.
			sans?: [...string]
		}]

		// Options defines the reference to a TLSOption, that specifies
		// the parameters of the TLS connection.
		// If not defined, the `default` TLSOption is used.
		// More info:
		// https://doc.traefik.io/traefik/v3.1/https/tls/#tls-options
		options?: {
			// Name defines the name of the referenced Traefik resource.
			name: string

			// Namespace defines the namespace of the referenced Traefik
			// resource.
			namespace?: string
		}

		// Passthrough defines whether a TLS router will terminate the TLS
		// connection.
		passthrough?: bool

		// SecretName is the name of the referenced Kubernetes Secret to
		// specify the certificate details.
		secretName?: string

		// Store defines the reference to the TLSStore, that will be used
		// to store certificates.
		// Please note that only `default` TLSStore can be used.
		store?: {
			// Name defines the name of the referenced Traefik resource.
			name: string

			// Namespace defines the namespace of the referenced Traefik
			// resource.
			namespace?: string
		}
	}
}
