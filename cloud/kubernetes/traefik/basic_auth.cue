package traefik

import (
	"github.com/augustfengd/augustfeng.app/cloud/kubernetes/traefik/secrets"
	"encoding/base64"
)

basic_auth: manifests: [{
	apiVersion: "v1"
	kind:       "Secret"
	metadata: name: "basic-auth"
	type: "kubernetes.io/basic-auth"
	data: {
		username: base64.Encode(null, secrets["basic-auth.json"]["username"])
		password: base64.Encode(null, secrets["basic-auth.json"]["password"])
	}
}]
