package prometheus

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

clusterroles:
	kubernetes.#clusterrole & {
		let #get = kubernetes.#clusterrole.#get
		let #list = kubernetes.#clusterrole.#list
		let #delete = kubernetes.#clusterrole.#delete
		let #create = kubernetes.#clusterrole.#create
		let #watch = kubernetes.#clusterrole.#watch
		let #update = kubernetes.#clusterrole.#update
		let #patch = kubernetes.#clusterrole.#patch

		name: "prometheus-operator"
		rules: {
			"monitoring.coreos.com": {
				"alertmanagers":               #get & #list & #watch & #update
				"alertmanagers/finalizers":    #get & #list & #watch & #update
				"alertmanagers/status":        #get & #list & #watch & #update
				"alertmanagerconfigs":         #get & #list & #watch & #update
				"prometheuses":                #get & #list & #watch & #update
				"prometheuses/finalizers":     #get & #list & #watch & #update
				"prometheuses/status":         #get & #list & #watch & #update
				"prometheusagents":            #get & #list & #watch & #update
				"prometheusagents/finalizers": #get & #list & #watch & #update
				"prometheusagents/status":     #get & #list & #watch & #update
				"thanosrulers":                #get & #list & #watch & #update
				"thanosrulers/finalizers":     #get & #list & #watch & #update
				"thanosrulers/status":         #get & #list & #watch & #update
				"scrapeconfigs":               #get & #list & #watch & #update
				"servicemonitors":             #get & #list & #watch & #update
				"podmonitors":                 #get & #list & #watch & #update
				"probes":                      #get & #list & #watch & #update
				"prometheusrules":             #get & #list & #watch & #update
			}
			"apps": {
				"statefulsets": #get & #list & #watch & #update
			}
			"": {
				"configmaps":          #get & #list & #watch & #update
				"secrets":             #get & #list & #watch & #update
				"pods":                #list & #delete
				"services":            #get & #create & #update & #delete
				"services/finalizers": #get & #create & #update & #delete
				"endpoints":           #get & #create & #update & #delete
				"nodes":               #list & #watch
				"namespaces":          #get & #list & #watch
				"events":              #patch & #create
			}
			"networking.k8s.io": {
				"ingresses": #get & #list & #watch
			}
			"storage.k8s.io": {
				"storageclasses": #get
			}
		}
	}

clusterrolebinding:
	kubernetes.#clusterrolebindings & {
		binding: "prometheus-operator": [{name: "prometheus-operator", namespace: "system-monitoring"}]
	}

serviceaccount:
	kubernetes.#serviceaccount & {name: "prometheus-operator"}
