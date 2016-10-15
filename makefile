.PHONY: all dotfiles dotconfig fonts

all: dotfiles dotconfig fonts

dotfiles:
	@for file in $(shell find $(CURDIR) -mindepth 1 -maxdepth 1 \
			-name ".*" -not -name ".fonts" -not -name ".config" \
			-not -regex ".*\.hg\(ignore\)?" -not -regex ".*\.git\(ignore\)?"); \
	do \
		ln -sfn $$file $(HOME)/$$(basename $$file); \
	done

dotconfig:
	@mkdir -p $(HOME)/.config
	@for file in $(shell find $(CURDIR)/.config -mindepth 1 -maxdepth 1); \
	do \
		ln -sfn $$file $(HOME)/.config/$$(basename $$file); \
	done

fonts:
	@ln -sfn $(CURDIR)/.fonts $(HOME)/.fonts
	@fc-cache -f $(HOME)/.fonts
