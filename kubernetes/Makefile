CERT_MANAGER_VERSION := v1.8.1

all: ../build/kubernetes downstream.cue

jsonnet/upstream/cert-manager.yaml: ; mkdir -p $(dir $@)
	docker run \
		--rm \
		-it \
		-v $${TMPDIR:=/tmp}:$${TMPDIR:=/tmp} \
		-e HOME=$${TMPDIR:=/tmp} \
		quay.io/jetstack/cert-manager-ctl:$(CERT_MANAGER_VERSION) \
		x install --dry-run > $@

downstream.cue: jsonnet/main.jsonnet jsonnet/utils.libsonnet jsonnet/cert-manager.libsonnet jsonnet/upstream/cert-manager.yaml
	jsonnet jsonnet/main.jsonnet | cue import -f json: - -p kubernetes --outfile $@

../build/kubernetes: $(wildcard *.cue) ; mkdir -p $@
	cue build && touch $@

.PHONY: clean
clean:
	rm -rf ../build/kubernetes
