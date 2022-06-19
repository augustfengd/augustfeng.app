THEMES := PaperMod
THEMES_DIR := ./themes

all: $(addprefix ${THEMES_DIR}/, ${THEMES})

$(THEMES_DIR)/PaperMod:
	mkdir -p $@
	wget -qO- "https://github.com/adityatelange/hugo-PaperMod/archive/master.tar.gz" | tar xzf - --strip-components=1 -C $@
