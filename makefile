XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share
XDG_BIN_HOME ?= $(HOME)/.local/bin
VIM_PLUG := .vim/autoload/plug.vim
JDTLS_HOME := $(XDG_DATA_HOME)/lsp/servers/eclipse-jdt-ls

.PHONY: dotfiles
dotfiles: $(XDG_CONFIG_HOME) fonts vim-plug jdtls bin
	@for file in $(shell find $(CURDIR) -mindepth 1 -maxdepth 1 -name ".*" \
			-not -name ".fonts" -not -name ".config" \
			-not -regex ".*\.git\(ignore\)?"); \
	do \
		ln -sfn $$file $(HOME)/$$(basename $$file); \
	done
	@for file in $(shell find $(CURDIR)/.config -mindepth 1 -maxdepth 1); \
	do \
		ln -sfn $$file $(XDG_CONFIG_HOME)/$$(basename $$file); \
	done

.PHONY: fonts
fonts: $(XDG_DATA_HOME)
	@ln -sfn $(CURDIR)/.fonts $(XDG_DATA_HOME)/fonts
	@fc-cache -f $(XDG_DATA_HOME)/fonts

.PHONY: vim-plug
vim-plug: $(VIM_PLUG)

$(VIM_PLUG):
	@curl -fLo $(VIM_PLUG) --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: jdtls
jdtls: $(JDTLS_HOME)
	@for file in $(shell find $(CURDIR)/jdtls -mindepth 1 -maxdepth 1); \
	do \
		ln -sfn $$file $(JDTLS_HOME)/$$(basename $$file); \
	done

define JDTLS_BIN :=
#!/usr/bin/env bash
set -eEuo pipefail
IFS=$$'\n\t'

$(JDTLS_HOME)/run.sh
endef

.PHONY: bin
bin: $(XDG_BIN_HOME)
	$(file > $(XDG_BIN_HOME)/jdtls,$(JDTLS_BIN))
	@chmod +x $(XDG_BIN_HOME)/jdtls
	@if command -v fdfind > /dev/null 2>&1; then \
		ln -sfn $(shell which fdfind) $(XDG_BIN_HOME)/fd; \
	fi

$(XDG_CONFIG_HOME):
	@mkdir -p $(XDG_CONFIG_HOME)

$(XDG_DATA_HOME):
	@mkdir -p $(XDG_DATA_HOME)

$(XDG_BIN_HOME):
	@mkdir -p $(XDG_BIN_HOME)

$(JDTLS_HOME):
	@mkdir -p $(JDTLS_HOME)
