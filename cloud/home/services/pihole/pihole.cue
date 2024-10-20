package pihole

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
	"encoding/yaml"
	"encoding/base64"
)

cm: pihole: {}

deployment:
	kubernetes.#deployment & {
		image: name:       "pihole/pihole"
		annotations: "cm": base64.Encode(null, yaml.Marshal(cm.pihole))
		expose: {
			ports: "web": 80
			ports: "dns": 53
		}
		mount: configmap: "pihole": {
			"/etc/pihole/custom.list":                    "custom.list"
			"/etc/dnsmasq.d/05-pihole-custom-cname.conf": "05-pihole-custom-cname.conf"
		}
		expose: protocol: "dns": "UDP"
		env: WEBPASSWORD: value: ""
	} & {
		manifests: [
			{
				// The running pod needs to let go of the host ports for the rollout to proceed.
				spec: strategy: type: "Recreate"
			},
			{}]
	}
