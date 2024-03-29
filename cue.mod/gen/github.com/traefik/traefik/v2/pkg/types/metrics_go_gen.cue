// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/traefik/traefik/v2/pkg/types

package types

// Metrics provides options to expose and send Traefik metrics to different third party monitoring systems.
#Metrics: {
	prometheus?: null | #Prometheus @go(Prometheus,*Prometheus) @toml(prometheus,omitempty)
	datadog?:    null | #Datadog    @go(Datadog,*Datadog) @toml(datadog,omitempty)
	statsD?:     null | #Statsd     @go(StatsD,*Statsd) @toml(statsD,omitempty)
	influxDB?:   null | #InfluxDB   @go(InfluxDB,*InfluxDB) @toml(influxDB,omitempty)
	influxDB2?:  null | #InfluxDB2  @go(InfluxDB2,*InfluxDB2) @toml(influxDB2,omitempty)
}

// Prometheus can contain specific configuration used by the Prometheus Metrics exporter.
#Prometheus: {
	buckets?: [...float64] @go(Buckets,[]float64) @toml(buckets,omitempty)
	addEntryPointsLabels?: bool   @go(AddEntryPointsLabels) @toml(addEntryPointsLabels,omitempty)
	addRoutersLabels?:     bool   @go(AddRoutersLabels) @toml(addRoutersLabels,omitempty)
	addServicesLabels?:    bool   @go(AddServicesLabels) @toml(addServicesLabels,omitempty)
	entryPoint?:           string @go(EntryPoint) @toml(entryPoint,omitempty)
	manualRouting?:        bool   @go(ManualRouting) @toml(manualRouting,omitempty)
	headerLabels?: {[string]: string} @go(HeaderLabels,map[string]string) @toml(headerLabels,omitempty)
}

// Datadog contains address and metrics pushing interval configuration.
#Datadog: {
	address?:              string @go(Address) @toml(address,omitempty)
	addEntryPointsLabels?: bool   @go(AddEntryPointsLabels) @toml(addEntryPointsLabels,omitempty)
	addRoutersLabels?:     bool   @go(AddRoutersLabels) @toml(addRoutersLabels,omitempty)
	addServicesLabels?:    bool   @go(AddServicesLabels) @toml(addServicesLabels,omitempty)
	prefix?:               string @go(Prefix) @toml(prefix,omitempty)
}

// Statsd contains address and metrics pushing interval configuration.
#Statsd: {
	address?:              string @go(Address) @toml(address,omitempty)
	addEntryPointsLabels?: bool   @go(AddEntryPointsLabels) @toml(addEntryPointsLabels,omitempty)
	addRoutersLabels?:     bool   @go(AddRoutersLabels) @toml(addRoutersLabels,omitempty)
	addServicesLabels?:    bool   @go(AddServicesLabels) @toml(addServicesLabels,omitempty)
	prefix?:               string @go(Prefix) @toml(prefix,omitempty)
}

// InfluxDB contains address, login and metrics pushing interval configuration.
#InfluxDB: {
	address?:              string @go(Address) @toml(address,omitempty)
	protocol?:             string @go(Protocol) @toml(protocol,omitempty)
	database?:             string @go(Database) @toml(database,omitempty)
	retentionPolicy?:      string @go(RetentionPolicy) @toml(retentionPolicy,omitempty)
	username?:             string @go(Username) @toml(username,omitempty)
	password?:             string @go(Password) @toml(password,omitempty)
	addEntryPointsLabels?: bool   @go(AddEntryPointsLabels) @toml(addEntryPointsLabels,omitempty)
	addRoutersLabels?:     bool   @go(AddRoutersLabels) @toml(addRoutersLabels,omitempty)
	addServicesLabels?:    bool   @go(AddServicesLabels) @toml(addServicesLabels,omitempty)
	additionalLabels?: {[string]: string} @go(AdditionalLabels,map[string]string) @toml(additionalLabels,omitempty)
}

// InfluxDB2 contains address, token and metrics pushing interval configuration.
#InfluxDB2: {
	address?:              string @go(Address) @toml(address,omitempty)
	token?:                string @go(Token) @toml(token,omitempty)
	org?:                  string @go(Org) @toml(org,omitempty)
	bucket?:               string @go(Bucket) @toml(bucket,omitempty)
	addEntryPointsLabels?: bool   @go(AddEntryPointsLabels) @toml(addEntryPointsLabels,omitempty)
	addRoutersLabels?:     bool   @go(AddRoutersLabels) @toml(addRoutersLabels,omitempty)
	addServicesLabels?:    bool   @go(AddServicesLabels) @toml(addServicesLabels,omitempty)
	additionalLabels?: {[string]: string} @go(AdditionalLabels,map[string]string) @toml(additionalLabels,omitempty)
}

// Statistics provides options for monitoring request and response stats.
#Statistics: {
	recentErrors?: int @go(RecentErrors) @toml(recentErrors,omitempty)
}
