package traefik

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

clusterroles:
	kubernetes.#clusterrole & {
		let #get = kubernetes.#clusterrole.#get
		let #list = kubernetes.#clusterrole.#list
		let #watch = kubernetes.#clusterrole.#watch
		let #update = kubernetes.#clusterrole.#watch

		name: "ingress-controller"
		rules: {
			"": {
				services:  #get & #list & #watch
				endpoints: #get & #list & #watch
				secrets:   #get & #list & #watch
			}
			"networking.k8s.io": {
				ingresses:      #get & #list & #watch
				ingressclasses: #get & #list & #watch
			}
			"networking.k8s.io": {
				"ingresses/status": #update
			}
			"traefik.io": {
				middlewares:       #get & #list & #watch
				middlewaretcps:    #get & #list & #watch
				ingressroutes:     #get & #list & #watch
				traefikservices:   #get & #list & #watch
				ingressroutetcps:  #get & #list & #watch
				ingressrouteudps:  #get & #list & #watch
				tlsoptions:        #get & #list & #watch
				tlsstores:         #get & #list & #watch
				serverstransports: #get & #list & #watch
			}
		}
	}

clusterrolebinding:
	kubernetes.#clusterrolebindings & {
		binding: "ingress-controller": [{name: "traefik", namespace: "system-ingress"}]
	}

serviceaccount:
	kubernetes.#serviceaccount & {name: "traefik"}
