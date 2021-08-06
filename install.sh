#! /usr/bin/bash

# Link things that should be linked in .config
list=("awesome/" "nvim/" "rofi/" "picom.conf" "dunst/" "qutebrowser/" )
for dir in ${list[@]}; do ln -s BetterThanYour/$dir ~/.config ; done

# Link things that should be linked in home directory XXX due to renaming possible issue if dir already exists
list=("mpd" "ncmpcpp" )
for dir in ${list[@]}; do ln -s ~/.config/BetterThanYour/$dir ~/.$dir ; done

