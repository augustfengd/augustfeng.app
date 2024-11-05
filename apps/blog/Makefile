TAR := $(if $(shell command -v gtar),gtar,tar)
CONTENT_FILES := $(shell find content/articles -type f)
THEME_FILES := \
	$(addprefix themes/, $(shell wget -qO- 'https://github.com/nanxiaobei/hugo-paper/archive/main.tar.gz' | $(TAR) tzf - --transform 's/hugo-paper-main/hugo-paper/' --show-transformed)) \
	$(shell find themes/augustfeng.app -type f)

.PHONY: all
all: build/public

build/public: $(THEME_FILES) $(CONTENT_FILES) ; @mkdir -p build
	@hugo --destination $@

$(THEME_FILES) &: ; @mkdir -p themes
	@wget -qO- 'https://github.com/nanxiaobei/hugo-paper/archive/main.tar.gz' | $(TAR) xzf - -C themes --transform 's/hugo-paper-main/hugo-paper/' --overwrite

# docker

docker.build: build/public
	@docker build . -t ghcr.io/augustfengd/augustfeng.app/blog:latest
	@touch $@

docker.push: docker.build
	@docker push ghcr.io/augustfengd/augustfeng.app/blog:latest
	@printf $$(docker inspect ghcr.io/augustfengd/augustfeng.app/blog:latest -f '{{index .RepoDigests 0}}' | cut -d @ -f 2) > $@

docker.pull: docker.push; cp $< $@

digest.cue: docker.pull
	cue import --force --package blog --path 'deployment: image: digest: ' --outfile $@ text: $<

.PHONY: clean
clean:
	rm -f .hugo_build.lock
	rm -rf build
	rm -rf themes/hugo-paper
	rm -f docker.build docker.push docker.pull digest.cue
