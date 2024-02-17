if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c "cat ~/.config/fish/fish_plugins | fisher install"
end

if status is-interactive
    set -g fish_greeting
end


# Jenv
eval set -gx PATH '/home/tnowad/.jenv/shims' $PATH
set -gx JENV_SHELL fish
set -gx JENV_LOADED 1
set -e JAVA_HOME
set -e JDK_HOME
jenv rehash 2>/dev/null
jenv refresh-plugins
function jenv
    set command $argv[1]
    set -e argv[1]

    switch "$command"
        case enable-plugin rehash shell shell-options
            jenv "sh-$command" $argv | source
        case '*'
            command jenv "$command" $argv
    end
end

# PNPM setup
if not type -q pnpm
    npm install -g pnpm
    pnpm setup
    pnpm install-completion fish
end

set -gx PNPM_HOME "/home/tnowad/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
