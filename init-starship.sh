#!/bin/sh
set -e

if [ -z "$(which stow)" ]; then
  echo "You need GNU Stow to proceed"
  exit
fi

echo "Checking if starship is already installed"
if [ -z "$(which starship)"]; then
 echo "Installing Starship" 
 curl -sS https://starship.rs/install.sh | sh
 echo "Starship installed"
fi

echo "Stowing starship"
stow starship
