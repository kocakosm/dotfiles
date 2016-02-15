.PHONY: all dotfiles fonts

all: fonts

dotfiles:
	@for file in $(shell find $(CURDIR) -maxdepth 1 -name ".*" \
			-not -regex ".*\.hg\(ignore\)?" -not -regex ".*\.git\(ignore\)?"); \
	do \
		ln -sf $$file $(HOME)/$$(basename $$file); \
	done

fonts: dotfiles
	@fc-cache -f $(HOME)/.fonts
