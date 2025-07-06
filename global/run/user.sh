#!/usr/bin/bash

SETUP_DIR=${SETUP_DIR:-$HOME/linux-setup}

source_file="${SETUP_DIR}/global/data/home/daniel/.aliases"
cp $source_file /home/daniel/.aliases
if [[ -f "${source_file}-local_$(hostname)" ]]; then
    source_file="${source_file}-local_$(hostname)"
    cp $source_file /home/daniel/.aliases-local_$(hostname)
fi

source_file="${SETUP_DIR}/global/data/home/daniel/.profile"
cp $source_file /home/daniel/.profile
if [[ -f "${source_file}-local_$(hostname)" ]]; then
    source_file="${source_file}-local_$(hostname)"
    cp $source_file /home/daniel/.profile-local_$(hostname)
fi

source_file="${SETUP_DIR}/global/data/home/daniel/.gitconfig"
cp $source_file /home/daniel/.gitconfig

# applications
sudo pamac install alacritty code thunderbird brave-browser

# discord update/install script
source_file="${SETUP_DIR}/global/data/home/daniel/bin/update-discord"
if [[ ! -d "/home/daniel/bin" ]]; then
    mkdir /home/daniel/bin
fi
cp $source_file /home/daniel/bin/update-discord
chmod +x /home/daniel/bin/update-discord