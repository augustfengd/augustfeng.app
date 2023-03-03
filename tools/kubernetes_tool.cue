import (
	"tool/exec"
	"tool/cli"
	"encoding/yaml"
	core "k8s.io/api/core/v1"
	apps "k8s.io/api/apps/v1"
	networking "k8s.io/api/networking/v1"
	traefik "github.com/traefik/traefik/v2/pkg/provider/kubernetes/crd/traefik/v1alpha1"
	certmanager "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
)

#manifest:
	core.#Namespace |
	core.#Pod |
	core.#Service |
	apps.#Deployment |
	apps.#StatefulSet |
	networking.#Ingress |
	traefik.#IngressRoute |
	certmanager.#Certificate

manifests: [...#manifest]

command: template: cli.Print & {
	text: yaml.MarshalStream(manifests)
}

command: diff: exec.Run & {
	cmd:   "kubectl diff -f -"
	stdin: yaml.MarshalStream(manifests)
}

command: apply: exec.Run & {
	cmd:   "kubectl apply -f -"
	stdin: yaml.MarshalStream(manifests)
}
