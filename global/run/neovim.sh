#!/usr/bin/bash

if [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/nvim" ]]; then
    echo "Neovim config already exists, skipping..."
    exit
fi

pamac install neovim unzip ripgrep xsel python-pynvim
git clone https://github.com/danielwuensche/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim" 
