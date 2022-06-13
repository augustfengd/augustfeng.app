# TODO: the recipes should be more complete and then eventually used in the gh workflows

all: build
all: build secrets

build: build/terraform/main.tf.json .github/workflows/terraform.yml

.PHONY: secrets
secrets:
	cd secrets; cue decrypt && cue convert

build/terraform/main.tf.json: terraform/terraform.cue config.cue
	mkdir -p $(dir $@)
	cue export -f --outfile $@ ./terraform/terraform.cue

.github/workflows/terraform.yml: .github/workflows.cue
	mkdir -p $(dir $@)
	cue export -f --outfile $@ .github/workflows.cue
.PHONY: clean
clean:
	cd secrets; cue clean
