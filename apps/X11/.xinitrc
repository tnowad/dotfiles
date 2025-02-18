#!/bin/sh

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

export GPG_TTY=$(tty)
export PATH="$PATH:$HOME/.local/bin"

# Merge X resources and keymaps if available
for file in /etc/X11/xinit/.Xresources "$HOME/.Xresources"; do
    [ -f "$file" ] && xrdb -merge "$file"
done

for file in /etc/X11/xinit/.Xmodmap "$HOME/.Xmodmap"; do
    [ -f "$file" ] && xmodmap "$file"
done

# Run startup scripts from xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
fi

# Start background services
pulseaudio --start &
feh --bg-fill --randomize ~/wallpapers/* &

# Start i3
exec i3
