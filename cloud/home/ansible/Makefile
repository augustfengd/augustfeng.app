.PHONY: all
all: build/inventory.yaml build/playbooks/installKubernetes.yaml build/ansible.cfg

build/inventory.yaml: ansible.cue ; mkdir -p build
	cue export --expression 'output.inventory' --outfile $@ --force

build/ansible.cfg: ansible.cue ; mkdir -p build
	cue export --expression 'output.ansibleCfg' --out text --outfile $@ --force

build/playbooks/installKubernetes.yaml: ansible.cue ; mkdir -p build/playbooks
	cue export --expression 'output.playbooks.installKubernetes' --outfile $@ --force
