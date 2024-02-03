.PHONY: setup install update purge

.DEFAULT_GOAL := setup

DOT_SCRIPTS := ./scripts
STOW := $(shell command -v stow 2> /dev/null)

check_stow:
ifndef STOW
		$(error No 'stow' in $$PATH)
endif

setup: check_stow
		@$(DOT_SCRIPTS)/setup
		@$(DOT_SCRIPTS)/install
		@$(DOT_SCRIPTS)/post_setup

install: check_stow
		@$(DOT_SCRIPTS)/install

update: check_stow
		@$(DOT_SCRIPTS)/update
		@$(DOT_SCRIPTS)/install

purge: check_stow
		@$(DOT_SCRIPTS)/purge

