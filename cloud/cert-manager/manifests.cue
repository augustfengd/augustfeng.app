package cert_manager

import (
	s "github.com/augustfengd/augustfeng.app/secrets"
	certmanager "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

clusterissuer:
	certmanager.#ClusterIssuer & {
		metadata: name: "letsencrypt"
		spec: acme: {
			email:  "augustfengd@gmail.com"
			server: "https://acme-v02.api.letsencrypt.org/directory"
			privateKeySecretRef: name: "letsencrypt-account-key"
			solvers: [{
				dns01: cloudDNS: project: "augustfengd"
			}]
		}
	}

secrets:
	kubernetes.#secrets & {
		"letsencrypt-account-key": "tls.key": s."lets-encrypt-secrets.json"."tls.key"
	}
