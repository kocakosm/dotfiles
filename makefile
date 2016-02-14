.PHONY: all dotfiles fc-cache

all: fc-cache

dotfiles:
	@for file in $(shell find $(CURDIR) -maxdepth 1 -name ".*" \
			-not -regex ".*\.hg\(ignore\)?" -not -regex ".*\.git\(ignore\)?"); \
	do \
		ln -sf $$file $(HOME)/$$(basename $$file); \
	done

fc-cache: dotfiles
	@fc-cache -f $(HOME)/.fonts
