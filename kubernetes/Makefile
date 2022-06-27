all: ../build/kubernetes

CERT_MANAGER_VERSION := v1.8.1
applications/upstream/cert-manager.yaml: ; mkdir -p $(dir $@)
	docker run \
		--rm \
		-it \
		-v $${TMPDIR:=/tmp}:$${TMPDIR:=/tmp} \
		-e HOME=$${TMPDIR:=/tmp} \
		quay.io/jetstack/cert-manager-ctl:$(CERT_MANAGER_VERSION) \
		x install --dry-run > $@

.PHONY: secrets
secrets:
	 for s in secrets/*.sops.json; do sops --output $${s/.sops.json/.json} -d $${s}; done

.PHONY: ../build/kubernetes # TODO: un-phony this.
../build/kubernetes: secrets; mkdir -p $@
	jsonnet --create-output-dirs \
		-S \
		--multi $@ \
		-e 'local utils = import "utils.libsonnet"; utils.build(import "main.libsonnet")'

.PHONY: clean
clean:
	rm -rf ../build/kubernetes
	for s in secrets/*.sops.json; do rm -f $${s/.sops.json/.json}; done
