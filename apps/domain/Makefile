all := k8s/manifests.yaml # ../../.github/workflows/apps.domain.yaml k8s/manifests.yaml

all: $(all)

../../.github/workflows/apps.domain.yaml: pipeline.cue
	cue export pipeline.cue --force --outfile $@

k8s/manifests.yaml: manifests.cue ; mkdir -p k8s
	cue export manifests.cue -e 'yaml.MarshalStream(manifests)' --force --outfile $@ --out text

.PHONY: clean
clean:
	rm -rf $(all)
