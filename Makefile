all: secrets build

.PHONY: secrets
secrets:
	cd secrets; cue decrypt && cue convert

build: build/terraform/main.tf.json .github/workflows/terraform.yml

build/terraform/main.tf.json: terraform/terraform.cue config.cue
	mkdir -p $(dir $@)
	cue export -f --outfile $@ $<

.github/workflows/terraform.yml: .github/workflows.cue
	mkdir -p $(dir $@)
	cue export -f --outfile $@ $<

.PHONY: clean
clean:
	rm -rf build
	cd secrets; cue clean
