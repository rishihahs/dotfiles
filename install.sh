#!/usr/bin/env zsh

CURRENT_DIR="${0:a:h}"
setopt EXTENDED_GLOB

# Download Prezto
if [[ -d "${CURRENT_DIR}/dotfiles/.zprezto" ]]; then
    rm -rf "${CURRENT_DIR}/dotfiles/.zprezto"
fi
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${CURRENT_DIR}/dotfiles/.zprezto"

# Download Vim Vundle
if [[ -d "${CURRENT_DIR}/dotfiles/.vim/bundle/Vundle.vim" ]]; then
    rm -rf "${CURRENT_DIR}/dotfiles/.vim/bundle/Vundle.vim"
fi
git clone https://github.com/gmarik/Vundle.vim.git "${CURRENT_DIR}/dotfiles/.vim/bundle/Vundle.vim"

# Symlink prezto files to home directory
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Symlink all dotfiles in dotfiles directory
for dotfile in "${CURRENT_DIR}"/dotfiles/.*; do
  ln -sfn "$dotfile" "${ZDOTDIR:-$HOME}/${dotfile:t}"
done
