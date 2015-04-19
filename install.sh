#!/usr/bin/env zsh

CURRENT_DIR="${0:a:h}"
setopt EXTENDED_GLOB

# Symlink all dotfiles in dotfiles directory
for dotfile in "${CURRENT_DIR}"/dotfiles/.*; do
  ln -s "$dotfile" "${ZDOTDIR:-$HOME}/.${dotfile:t}"
done

# Symlink prezto files to home directory
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
