set -g fish_greeting

if test (tty) = "/dev/tty1"
    exec startx
end

if status is-interactive
end

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c "cat ~/.config/fish/fish_plugins | fisher install"
end

if type -q node
    nvm use default >/dev/null &
end

if not type -q pnpm
    npm install -g pnpm
    pnpm setup
    pnpm install-completion fish
end

set -gx PNPM_HOME "/home/tnowad/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

export CCACHE_DIR="/var/cache/ccache"
export RUSTC_WRAPPER="/usr/bin/sccache"
export SCCACHE_DIR="/var/cache/sccache"
export SCCACHE_MAX_FRAME_LENGTH="104857600"

export EDITOR="nvim"
source "$HOME/.cargo/env.fish"

[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

