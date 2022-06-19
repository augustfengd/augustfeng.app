package kubernetes

applications: "blog": {
	#config: {
		remote: {
			url:      "https://github.com/augustfengd/augustfeng.app.git"
			revision: "main"
		}
	}
	Namespace: {
		"blog": {
			apiVersion: "v1"
		}
	}
	Deployment: {
		"blog": {
			apiVersion: "apps/v1"
			metadata: {
				namespace: Namespace["blog"].metadata.name
			}
			spec: {
				selector: matchLabels: template.metadata.labels
				template: {
					metadata: labels: {
						app: "hugo"
					}
					spec: containers: [
						{
							name:  "hugo"
							image: "klakegg/hugo"
							args: ["server"]
							ports: [{containerPort: 1313}]
							volumeMounts: [{name: "src", mountPath: "/src", subPath: "web/blog"}]
						},
					]
					spec: initContainers: [
						{
							name:  "git-clone"
							image: "alpine/git"
							command: ["git", "clone", #config.remote.url, "/src"]
							volumeMounts: [{name: "src", mountPath: "/src"}]
						},
						{
							name:  "git-switch"
							image: "alpine/git"
							command: ["git", "-C", "/src", "switch", #config.remote.revision]
							volumeMounts: [{name: "src", mountPath: "/src"}]
						},
						{
							name:  "gcc"
							image: "gcc" // #TODO: gcc is a heavy container. find something else.
							args: ["make", "-C", "/blog"]
							volumeMounts: [{name: "src", mountPath: "/blog", subPath: "web/blog"}]
						},
					]
					spec: volumes: [
						{
							name: "src"
							emptyDir: {}
						},
					]
				}
			}
		}
	}
	Service: {
		"blog": {
			apiVersion: "v1"
			metadata: {
				namespace: Namespace["blog"].metadata.name
			}
			spec: {
				ports: [
					{
						port:       1313
						targetPort: 1313
					},
				]
				selector: Deployment["blog"].spec.template.metadata.labels
			}
		}
	}
}
