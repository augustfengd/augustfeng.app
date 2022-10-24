all: build/terraform .github/workflows

.PHONY: kubernetes
kubernetes:
	cd kubernetes; $(MAKE)

build/terraform: cloud
	mkdir -p build/terraform
	cd cloud/_secrets; cue decrypt && cue convert
	cue export -f ./cloud/augustfeng.app:terraform -e configuration --outfile build/terraform/main.tf.json

build/kubernetes: cloud
	mkdir -p build/kubernetes
	cue export -f ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(manifests)' --out text --outfile build/kubernetes/cloud.yaml

.github/workflows: cloud containers
	mkdir -p $@
	cue export -f ./cloud/augustfeng.app:pipeline --outfile ./.github/workflows/cloud.yaml
	cue export -f ./containers:pipeline --outfile ./.github/workflows/containers.yaml

.PHONY: clean
clean:
	rm -rf build/kubernetes
	rm -rf build/terraform
	rm -rf .github/workflows
