#!/bin/sh
set -e

if [ -z "$(which stow)" ]; then
  echo "You need GNU Stow to proceed"
  exit
fi

echo "Symlinking tmux conf"
stow tmux

echo "Cloning tpm"
# remove if it exists
rm -rf $HOME/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

