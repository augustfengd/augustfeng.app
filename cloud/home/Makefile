.PHONY: all
all: build/inventory.yaml build/playbook/installKubernetes.yaml build/ansible.cfg

build/inventory.yaml: ansible.cue ; mkdir -p build
	cue export ansible.cue --expression 'inventoryYaml' --outfile $@ --force

build/ansible.cfg: ansible.cue ; mkdir -p build
	cue export ansible.cue --expression 'ansibleCfg' --out text --outfile $@ --force

build/playbooks/installKubernetes.yaml: ansible.cue ; mkdir -p build
	cue export ansible.cue --expression 'installKubernetesYaml' --outfile $@ --force
