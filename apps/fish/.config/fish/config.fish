if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c "cat ~/.config/fish/fish_plugins | fisher install"
end

if status is-interactive
    set -g fish_greeting
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

export EDITOR="nvim"
source "$HOME/.cargo/env.fish"

[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
