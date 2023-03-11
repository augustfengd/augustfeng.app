all: build/terraform build/argocd .github/workflows

.PHONY: build/terraform
build/terraform: cloud
	mkdir -p build/terraform
	cd cloud/secrets; cue decrypt && cue convert
	cue export -f ./cloud/augustfeng.app:terraform -e configuration --outfile build/terraform/main.tf.json

.PHONY: build/argocd
build/argocd: cloud
	jsonnet -m build/argocd -c cloud/argocd/argocd.jsonnet --tla-str fqdn=argocd.augustfeng.app --tla-code-file argocdCmpSecrets=cloud/secrets/sops-secrets.json

.PHONY: build/kubernetes
build/kubernetes: cloud
	mkdir -p build/kubernetes
	cue export -f ./cloud/augustfeng.app:kubernetes -e 'yaml.MarshalStream(manifests)' --out text --outfile build/kubernetes/cloud.yaml

.PHONY: .github/workflows
.github/workflows:
	mkdir -p $@
	cue export -f ./cloud/augustfeng.app:pipeline --outfile ./.github/workflows/cloud.yaml
	cue export -f ./containers:pipeline --outfile ./.github/workflows/containers.yaml

kubeconfig.yaml: tools/kubeconfig_tool.cue
	cue create $<

.PHONY: clean
clean:
	rm -rf build/kubernetes
	rm -rf build/terraform
	rm -rf .github/workflows
