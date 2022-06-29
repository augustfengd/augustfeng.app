all: ../build/terraform/main.tf.json

.PHONY: ../build/terraform/main.tf.json # TODO: un-phony this.
../build/terraform/main.tf.json: terraform.cue ; mkdir -p $(dir $@)
	cue export -f --outfile $@ $<

.PHONY: clean
clean:
	rm -rf ../build/terraform
