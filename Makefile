all: terraform .github/workflows

.PHONY: kubernetes
kubernetes:
	cd kubernetes; $(MAKE)

.PHONY: terraform
terraform:
	cd terraform/secrets; cue decrypt && cue convert
	cd terraform; cue build :scripts

.PHONY: .github/workflows
.github/workflows:
	mkdir -p $@
	cd .github; cue build :scripts

.PHONY: clean
clean:
	rm -rf build/kubernetes
	rm -rf build/terraform
	rm -rf .github/workflows
