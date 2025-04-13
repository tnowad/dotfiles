set -g fish_greeting

if test (tty) = "/dev/tty1"
    exec startx
end

if status is-interactive
    if test -z "$TMUX"; and test "$TERM" = "xterm-kitty"
        exec tmux new-session -A -s main
    end
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

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

export EDITOR="nvim"
set -x ANDROID_HOME $HOME/Android/Sdk
set -x PATH $PATH $HOME/.local/scripts $ANDROID_HOME/tools $ANDROID_HOME/platform-tools

# pnpm
set -gx PNPM_HOME "/home/tnowad/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
