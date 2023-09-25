.PHONY: all
all: build/inventory.yaml build/playbooks/installKubernetes.yaml build/ansible.cfg

build/inventory.yaml: ansible.cue ; mkdir -p build
	cue export --expression 'build.inventory' --outfile $@ --force

build/ansible.cfg: ansible.cue ; mkdir -p build
	cue export --expression 'build.ansibleCfg' --out text --outfile $@ --force

build/playbooks/installKubernetes.yaml: ansible.cue ; mkdir -p build/playbooks
	cue export --expression 'build.playbooks.installKubernetes' --outfile $@ --force
