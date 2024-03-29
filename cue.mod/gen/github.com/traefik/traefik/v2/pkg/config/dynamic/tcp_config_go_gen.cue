// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/traefik/traefik/v2/pkg/config/dynamic

package dynamic

import "github.com/traefik/traefik/v2/pkg/types"

// TCPConfiguration contains all the TCP configuration parameters.
#TCPConfiguration: {
	routers?: {[string]: null | #TCPRouter} @go(Routers,map[string]*TCPRouter) @toml(routers,omitempty)
	services?: {[string]: null | #TCPService} @go(Services,map[string]*TCPService) @toml(services,omitempty)
	middlewares?: {[string]: null | #TCPMiddleware} @go(Middlewares,map[string]*TCPMiddleware) @toml(middlewares,omitempty)
}

// TCPService holds a tcp service configuration (can only be of one type at the same time).
#TCPService: {
	loadBalancer?: null | #TCPServersLoadBalancer @go(LoadBalancer,*TCPServersLoadBalancer) @toml(loadBalancer,omitempty)
	weighted?:     null | #TCPWeightedRoundRobin  @go(Weighted,*TCPWeightedRoundRobin) @toml(weighted,omitempty)
}

// TCPWeightedRoundRobin is a weighted round robin tcp load-balancer of services.
#TCPWeightedRoundRobin: {
	services?: [...#TCPWRRService] @go(Services,[]TCPWRRService) @toml(services,omitempty)
}

// TCPWRRService is a reference to a tcp service load-balanced with weighted round robin.
#TCPWRRService: {
	name?:   string     @go(Name) @toml(name,omitempty)
	weight?: null | int @go(Weight,*int) @toml(weight,omitempty)
}

// TCPRouter holds the router configuration.
#TCPRouter: {
	entryPoints?: [...string] @go(EntryPoints,[]string) @toml(entryPoints,omitempty)
	middlewares?: [...string] @go(Middlewares,[]string) @toml(middlewares,omitempty)
	service?:  string                     @go(Service) @toml(service,omitempty)
	rule?:     string                     @go(Rule) @toml(rule,omitempty)
	priority?: int                        @go(Priority) @toml(priority,omitempty,omitzero)
	tls?:      null | #RouterTCPTLSConfig @go(TLS,*RouterTCPTLSConfig) @toml(tls,omitempty)
}

// RouterTCPTLSConfig holds the TLS configuration for a router.
#RouterTCPTLSConfig: {
	passthrough:   bool   @go(Passthrough) @toml(passthrough)
	options?:      string @go(Options) @toml(options,omitempty)
	certResolver?: string @go(CertResolver) @toml(certResolver,omitempty)
	domains?: [...types.#Domain] @go(Domains,[]types.Domain) @toml(domains,omitempty)
}

// TCPServersLoadBalancer holds the LoadBalancerService configuration.
#TCPServersLoadBalancer: {
	// TerminationDelay, corresponds to the deadline that the proxy sets, after one
	// of its connected peers indicates it has closed the writing capability of its
	// connection, to close the reading capability as well, hence fully terminating the
	// connection. It is a duration in milliseconds, defaulting to 100. A negative value
	// means an infinite deadline (i.e. the reading capability is never closed).
	terminationDelay?: null | int            @go(TerminationDelay,*int) @toml(terminationDelay,omitempty)
	proxyProtocol?:    null | #ProxyProtocol @go(ProxyProtocol,*ProxyProtocol) @toml(proxyProtocol,omitempty)
	servers?: [...#TCPServer] @go(Servers,[]TCPServer) @toml(servers,omitempty)
}

// TCPServer holds a TCP Server configuration.
#TCPServer: {
	address?: string @go(Address) @toml(address,omitempty)
}

// ProxyProtocol holds the PROXY Protocol configuration.
// More info: https://doc.traefik.io/traefik/v2.10/routing/services/#proxy-protocol
#ProxyProtocol: {
	// Version defines the PROXY Protocol version to use.
	version?: int @go(Version) @toml(version,omitempty)
}
