#! /usr/bin/bash

list=("alacritty/" "awesome/" "fish/" "nvim/" "rofi/")
for dir in ${list[@]}; do ln -s BetterThanYour/$dir ~/.config ; done
