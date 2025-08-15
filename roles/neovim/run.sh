#!/usr/bin/bash

source "$SETUP_DIR/lib/packages.sh"

packages__arch=(
    "neovim"
    "unzip"
    "ripgrep"
    "python-pynvim"
)

neovim_config_git="https://github.com/danielwuensche/nvim-config.git"
neovim_config_dir="$user_home/.config/nvim"

###

### packages
var_packages="packages__$distro"
cmd_packages_install_missing "${!var_packages}"

### config
if ! [ -d "$neovim_config_dir" ] && [ "$user_name" != "root" ]; then
    mkdir -p "$neovim_config_dir"
    git clone "$neovim_config_git" "$neovim_config_dir"
fi

cd "$neovim_config_dir" || exit
[ -n "$(git fetch)" ] && git pull
