all: workflows/terraform.yml

.PHONY: workflows/terraform.yml
workflows/terraform.yml: ; mkdir -p $(dir $@)
	cue export -f --outfile $@ $<

.PHONY: clean
clean:
	rm -rf workflows
