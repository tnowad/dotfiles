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

PS1='[\[\033[32m\]\u@\h \[\033[34m\]\W\[\033[31m\] \t\[\033[36m\]$(parse_git_branch)\[\033[00m\]]\$ '
. "$HOME/.cargo/env"
