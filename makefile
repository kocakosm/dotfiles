vim-plug := .vim/autoload/plug.vim
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

.PHONY: dotfiles
dotfiles: fonts vim-plug
	@for file in $(shell find $(CURDIR) -mindepth 1 -maxdepth 1 -name ".*" \
			-not -name ".fonts" -not -name ".config" -not -name ".tags" \
			-not -regex ".*\.git\(ignore\)?"); \
	do \
		ln -sfn $$file $(HOME)/$$(basename $$file); \
	done
	@mkdir -p $(XDG_CONFIG_HOME)
	@for file in $(shell find $(CURDIR)/.config -mindepth 1 -maxdepth 1); \
	do \
		ln -sfn $$file $(XDG_CONFIG_HOME)/$$(basename $$file); \
	done

.PHONY: fonts
fonts:
	@mkdir -p $(XDG_DATA_HOME)
	@ln -sfn $(CURDIR)/.fonts $(XDG_DATA_HOME)/fonts
	@fc-cache -f $(XDG_DATA_HOME)/fonts

.PHONY: vim-plug
vim-plug: $(vim-plug)

$(vim-plug):
	@curl -fLo $(vim-plug) --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
