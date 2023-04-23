package cert_manager

import (
	s "github.com/augustfengd/augustfeng.app/secrets"
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

clusterissuer:
	kubernetes.#clusterissuer

secrets:
	kubernetes.#secrets & {
		"letsencrypt-account-key": "tls.key": s."lets-encrypt-secrets.json"."tls.key"
	}
