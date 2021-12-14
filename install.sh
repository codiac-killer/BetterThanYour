#! /usr/bin/bash

# Link things that should be linked in .config
list=("picom.conf" "dunst/" "qutebrowser/" )
for conf in ${list[@]}; do ln -s BetterThanYour/$conf ~/.config ; done

# Link things that should be linked in $HOME
list=("vim/" ".zshrc" )
for conf in ${list[@]}; do ln -s .config/BetterThanYour/$conf ~/ ; done
