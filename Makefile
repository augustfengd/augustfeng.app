# TODO: the recipes should be more complete and then eventually used in the gh workflows

all: build

build: build/terraform/main.tf.json .github/workflows/terraform.yml

build/terraform/main.tf.json: terraform/terraform.cue config.cue
	mkdir -p $(dir $@)
	cue export -f --outfile $@ ./terraform/terraform.cue

.github/workflows/terraform.yml: .github/workflows.cue
	mkdir -p $(dir $@)
	cue export -f --outfile $@ .github/workflows.cue
