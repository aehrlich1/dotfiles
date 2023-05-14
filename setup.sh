#!/bin/bash

source ./helper/echos.sh
source ./helper/symlink.sh
source ./helper/vars.sh

print_header "Emacs"
symlink "$DOTFILES/emacs/.emacs" "$HOME/.emacs"