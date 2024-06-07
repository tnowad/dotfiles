#!/bin/bash

export PATH="/usr/lib/ccache/bin${PATH:+:}${PATH}"
export CCACHE_DIR="/var/cache/ccache"

export RUSTC_WRAPPER="/usr/bin/sccache"
export SCCACHE_DIR="/var/cache/sccache"
export SCCACHE_MAX_FRAME_LENGTH="104857600"

HISTSIZE=1000
HISTFILESIZE=1000

GPG_TTY=$(tty)
EDITOR=nvim

export GPG_TTY
export EDITOR

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

. "$HOME/.cargo/env"
