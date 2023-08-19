manifests := k8s/rbac.yaml k8s/workload.yaml
pipelines := ../../.github/workflows/apps.domain.yaml

all: $(manifests) $(pipelines)

../../.github/workflows/apps.domain.yaml: pipeline.cue
	cue export pipeline.cue --force --outfile $@

k8s/rbac.yaml: manifests.cue ; mkdir -p k8s
	cue export manifests.cue -e 'yaml.MarshalStream(manifests.rbac)' --force --outfile $@ --out text

k8s/workload.yaml: manifests.cue ; mkdir -p k8s
	cue export manifests.cue -e 'yaml.MarshalStream(manifests.cronjob)' --force --outfile $@ --out text

.PHONY: clean
clean:
	rm -rf $(all)
	touch -d @0 $(manifests)
