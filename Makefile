all: build/kubernetes build/terraform .github/workflows

build/kubernetes: kubernetes
	cd $<; $(MAKE)

build/terraform: terraform
	cd $<; $(MAKE)

.github/workflows: .github/workflows.cue
	cd $(dir $<); $(MAKE)

.PHONY: clean
clean:
	cd kubernetes; $(MAKE) clean
	cd terraform; $(MAKE) clean
	rm -rf .github/workflows
