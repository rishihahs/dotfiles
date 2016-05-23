#!/usr/bin/env zsh

CURRENT_DIR="${0:a:h}"
setopt EXTENDED_GLOB

# Download Prezto
if [[ -d "${CURRENT_DIR}/dotfiles/.zprezto" ]]; then
    rm -rf "${CURRENT_DIR}/dotfiles/.zprezto"
fi
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${CURRENT_DIR}/dotfiles/.zprezto"

# Download tmux plugin manager
if [[ -d "${CURRENT_DIR}/dotfiles/.tmux" ]]; then
    rm -rf "${CURRENT_DIR}/dotfiles/.tmux"
fi
git clone https://github.com/tmux-plugins/tpm "${CURRENT_DIR}/dotfiles/.tmux/plugins/tpm"

# Create nvim directory
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
if [[ -d "${XDG_CONFIG_HOME}/nvim" ]]; then
    mv "${XDG_CONFIG_HOME}/nvim" "${XDG_CONFIG_HOME}/nvim.bak"
fi

# Download Vim Dein
sh <(curl -fsSL https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh) ${XDG_CONFIG_HOME}/nvim

# Symlink prezto files to home directory
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Symlink all dotfiles in dotfiles directory
for dotfile in "${CURRENT_DIR}"/dotfiles/.*; do
  ln -sfn "$dotfile" "${ZDOTDIR:-$HOME}/${dotfile:t}"
done

# Symlink .vimrc to .config/nvim/init.vim
ln -s "${CURRENT_DIR}/dotfiles/.vimrc" $XDG_CONFIG_HOME/nvim/init.vim
