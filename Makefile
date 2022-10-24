all: build/terraform .github/workflows

.PHONY: kubernetes
kubernetes:
	cd kubernetes; $(MAKE)

build/terraform: cloud
	mkdir -p build/terraform
	cd cloud/_secrets; cue decrypt && cue convert
	cue export -f ./cloud/augustfeng.app:terraform -e configuration --outfile build/terraform/main.tf.json

.github/workflows: cloud
	mkdir -p $@
	cue export -f ./cloud/augustfeng.app:pipeline --outfile ./.github/workflows/cloud.yaml

.PHONY: clean
clean:
	rm -rf build/kubernetes
	rm -rf build/terraform
	rm -rf .github/workflows
