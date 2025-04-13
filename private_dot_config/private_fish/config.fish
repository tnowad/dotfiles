# Disable greeting
set -g fish_greeting

# Start X on tty1
if test (tty) = "/dev/tty1"
    exec startx
end

# Start tmux in interactive Kitty terminal
if status is-interactive
    if test -z "$TMUX"; and test "$TERM" = "xterm-kitty"
        exec tmux new-session -A -s main
    end
end
