#! /usr/bin/bash

list=("alacritty/" "awesome/" "fish/" "nvim/" "rofi/" "picom.conf")
for dir in ${list[@]}; do ln -s BetterThanYour/$dir ~/.config ; done
