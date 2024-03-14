package prometheus

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

prometheus_operator: {
	clusterroles:
		kubernetes.#clusterrole & {
			let #get = kubernetes.#clusterrole.#get
			let #list = kubernetes.#clusterrole.#list
			let #delete = kubernetes.#clusterrole.#delete
			let #create = kubernetes.#clusterrole.#create
			let #watch = kubernetes.#clusterrole.#watch
			let #update = kubernetes.#clusterrole.#update
			let #patch = kubernetes.#clusterrole.#patch
			let #all = kubernetes.#clusterrole.#all

			name: "prometheus-operator"
			rules: {
				"monitoring.coreos.com": {
					"alertmanagers":               #all
					"alertmanagers/finalizers":    #all
					"alertmanagers/status":        #all
					"alertmanagerconfigs":         #all
					"prometheuses":                #all
					"prometheuses/finalizers":     #all
					"prometheuses/status":         #all
					"prometheusagents":            #all
					"prometheusagents/finalizers": #all
					"prometheusagents/status":     #all
					"thanosrulers":                #all
					"thanosrulers/finalizers":     #all
					"thanosrulers/status":         #all
					"scrapeconfigs":               #all
					"servicemonitors":             #all
					"podmonitors":                 #all
					"probes":                      #all
					"prometheusrules":             #all
				}
				"apps": {
					"statefulsets": #all
				}
				"": {
					"configmaps":          #all
					"secrets":             #all
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
}

prometheus: {
	clusterroles:
		kubernetes.#clusterrole & {
			let #get = kubernetes.#clusterrole.#get
			let #list = kubernetes.#clusterrole.#list
			let #watch = kubernetes.#clusterrole.#watch

			name: "prometheus"
			rules: {
				"": {
					"nodes":         #get & #list & #watch
					"nodes/metrics": #get & #list & #watch
					"services":      #get & #list & #watch
					"endpoints":     #get & #list & #watch
					"pods":          #get & #list & #watch
					"configmaps":    #get
				}
				"networking.k8s.io": {
					"ingresses": #get & #list & #watch
				}
				"/metrics": #get
			}
		}

	clusterrolebinding:
		kubernetes.#clusterrolebindings & {
			binding: "prometheus": [{name: "prometheus", namespace: "system-monitoring"}]
		}

	serviceaccount:
		kubernetes.#serviceaccount & {name: "prometheus"}
}
