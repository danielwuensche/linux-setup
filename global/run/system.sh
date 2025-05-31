#!/usr/bin/bash

SETUP_DIR=${SETUP_DIR:-$HOME/linux-setup}

# NTP
sudo timedatectl set-ntp 1

# pacman mirrors
sudo pacman-mirrors -c Germany,Czech,Netherlands,Austria

# tlp
sudo pamac install tlp tlpui
tlp_conf="${SETUP_DIR}/global/data/etc/tlp.conf"
if [[ -f "${tlp_conf}-local_$(hostname)" ]]; then
    tlp_conf="${tlp_conf}-local_$(hostname)"
fi
sudo cp $tlp_conf /etc/tlp.conf
sudo chown root:root /etc/tlp.conf
sudo chmod 0644 /etc/tlp.conf
sudo systemctl enable --now tlp

$ thermald
sudo pamac install thermald
sudo systemctl enable --now thermald
sudo newgrp power
sudo gpasswd -a $USER power
