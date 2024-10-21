package pihole

import (
	"github.com/augustfengd/augustfeng.app/cue.lib/kubernetes"
)

cm:
	kubernetes.#configmaps & {
		pihole: {
			"05-pihole-custom-cname.conf": """
				cname=pihole.home.arpa,home.arpa
				cname=pairdrop.home.arpa,home.arpa
				cname=syncthing.home.arpa,home.arpa
				cname=traefik.home.arpa,home.arpa
				cname=laptop2020.home.arpa,home.arpa
				"""
			"custom.list": """
				192.168.0.254 home.arpa
				192.168.0.13 android.home.arpa
				"""
		}
	}
