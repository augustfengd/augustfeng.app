TAR := $(if $(shell command -v gtar),gtar,tar)
CONTENT_FILES := $(shell find content/articles -type f)
THEME_FILES := \
	$(addprefix themes/, $(shell wget -qO- 'https://github.com/nanxiaobei/hugo-paper/archive/master.tar.gz' | $(TAR) tzf - --transform 's/hugo-paper-main/hugo-paper/' --show-transformed)) \
	$(shell find themes/augustfeng.app -type f)

.PHONY: all
all: ../../.github/workflows/apps.blog.yaml build/public

../../.github/workflows/apps.blog.yaml: pipeline.cue ../../cloud/pipeline.cue
	@cue export -f  pipeline.cue -o $@

build/public: $(THEME_FILES) $(CONTENT_FILES) ; @mkdir -p build
	@docker run -v $(CURDIR):/src klakegg/hugo --destination $@

$(THEME_FILES) &: ; @mkdir -p themes
	@wget -qO- 'https://github.com/nanxiaobei/hugo-paper/archive/master.tar.gz' | $(TAR) xzf - -C themes --transform 's/hugo-paper-main/hugo-paper/' --overwrite

# operations

.PHONY: server
server: $(THEME_FILES) $(CONTENT_FILES)
	@docker run -it -v $(CURDIR):/src -p 1313:1313 klakegg/hugo server

.PHONY: build
build: build/public
	@docker build . -t ghcr.io/augustfengd/augustfeng.app/blog:latest

.PHONY: push
push: build
	@docker push ghcr.io/augustfengd/augustfeng.app/blog:latest

.PHONY: digest.cue
digest.cue:
	sed -i "s/string/\"$$(docker inspect ghcr.io/augustfengd/augustfeng.app/blog:latest -f '{{index .RepoDigests 0}}' | cut -d @ -f 2)\"/" digest.cue

.PHONY: manifests
manifests: ; @docker pull ghcr.io/augustfengd/augustfeng.app/blog:latest ; mkdir -p build
	@docker inspect ghcr.io/augustfengd/augustfeng.app/blog:latest | docker run -i -v $(CURDIR)/../../:/augustfeng.app -w /augustfeng.app/apps/blog cuelang/cue export -f -e 'yaml.MarshalStream(manifests)' -o=text:build/manifests.yaml kube.cue -l "_image:" json: -

.PHONY: apply
apply: manifests
	@docker run -v $(CURDIR)/../../:/augustfeng.app -w /augustfeng.app/apps/blog -e KUBECONFIG=${KUBECONFIG} -e GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS} -v $(pwd)/${GOOGLE_APPLICATION_CREDENTIALS}:/${GOOGLE_APPLICATION_CREDENTIALS} bitnami/kubectl:1.25 apply --namespace apps-blog -f build/manifests.yaml

.PHONY: clean
clean:
	rm -rf build
	rm -rf themes/hugo-paper
	rm -rf ../../.github/workflows/apps.blog.yaml
