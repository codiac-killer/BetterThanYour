# Enable Features --------------------------------------------------------------
# Case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# automatically find new executables in path
zstyle ':completion:*' rehash true
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500
# Don't consider certain characters part of the word
WORDCHARS=${WORDCHARS//\/[&.;]}

# Immediately append history instead of overwriting
setopt appendhistory
# If a new command is a duplicate, remove the older one
setopt histignorealldups
# if only directory path is entered, cd there.
setopt autocd

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '%F{13}%b%f%F{1}%u%c%f'
zstyle ':vcs_info:git:*' actionformats '%b%F{1}|%a%u%c%f'

# ------------------------------------------------------------------------------

# Set prompt theme -------------------------------------------------------------
export PROMPT='%B%n %F{magenta}@%f %F{blue}%m%f %F{magenta}in%f %2~ ${vcs_info_msg_0_}%b'$'\n'"%(?.%B%F{2}:%)%f%b.%B%F{1}X(%f%b) %F{1}%B$%b%f "
# Enter new line after each command
# The function set its self to be effective after the first time it is called
# So the first prompt is stuck to the top of terminal
precmd(){ precmd(){ print "" } }
# ------------------------------------------------------------------------------

# Plugins ----------------------------------------------------------------------
# Auto-suggestion ***********************************************
if [ ! -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]
then
  # Get plugin if not installed
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# ***************************************************************

# Syntax Hightlighting ******************************************
if [ ! -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]
then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ***************************************************************

# Improved vi keybinds ******************************************
if [ ! -f ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]
then
  git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/zsh-vi-mode
fi
source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# ***************************************************************
# ------------------------------------------------------------------------------

# Keybindings ------------------------------------------------------------------
# Enable ctrl+Backspace - killword
bindkey '^H' backward-kill-word
# Enable ctrl+Delete - killword
bindkey '^[[3;5~' kill-word

# Home Key
bindkey '^[[7~' beginning-of-line
bindkey '^[[H' beginning-of-line
# End Key
bindkey '^[[8~' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[F' end-of-line
# Insert Key
bindkey '^[[2~' overwrite-mode
# Delete key
bindkey "\e[3~" delete-char
bindkey "^[[P" delete-char

# Ctrl + Arrow Left
bindkey '^[Od' backward-word
bindkey '^[[1;5D' backward-word
# Ctrl + Arrow Right
bindkey '^[Oc' forward-word
bindkey '^[[1;5C' forward-word
# ------------------------------------------------------------------------------

# Features ---------------------------------------------------------------------
set -o vi
# ------------------------------------------------------------------------------

# Functions --------------------------------------------------------------------
# Downloads mp3 from youtube link
mp3dl () {
  youtube-dl -x --audio-format mp3 --prefer-ffmpeg $@
}
# calculates math expresions
calc () {python -c "from math import *; print($*)";}
# Function for checking crypto values
value(){while true; do clear; curl eur.rate.sx/$1@$2; sleep 100; done}
# ------------------------------------------------------------------------------

# Aliases ----------------------------------------------------------------------
alias ls='ls --color=auto'
# ------------------------------------------------------------------------------

# Add current dir to PATH ------------------------------------------------------
export PATH=$PATH:.
# ------------------------------------------------------------------------------
