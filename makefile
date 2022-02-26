vim-plug := .vim/autoload/plug.vim

.PHONY: all
all: dotfiles dotconfig vim-plug fonts

.PHONY: dotfiles
dotfiles:
	@for file in $(shell find $(CURDIR) -mindepth 1 -maxdepth 1 \
			-name ".*" -not -name ".fonts" -not -name ".config" \
			-not -regex ".*\.git\(ignore\)?"); \
	do \
		ln -sfn $$file $(HOME)/$$(basename $$file); \
	done

.PHONY: dotconfig
dotconfig:
	@mkdir -p $(HOME)/.config
	@for file in $(shell find $(CURDIR)/.config -mindepth 1 -maxdepth 1); \
	do \
		ln -sfn $$file $(HOME)/.config/$$(basename $$file); \
	done

.PHONY: fonts
fonts:
	@ln -sfn $(CURDIR)/.fonts $(HOME)/.fonts
	@fc-cache -f $(HOME)/.fonts

.PHONY: vim-plug
vim-plug: $(vim-plug)

$(vim-plug):
	@curl -fLo $(vim-plug) --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
