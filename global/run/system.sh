#!/usr/bin/bash

SETUP_DIR=${SETUP_DIR:-$HOME/linux-setup}

# NTP
sudo timedatectl set-ntp 1

# pacman mirrors
sudo pacman-mirrors -c Germany,Czechia,Netherlands,Austria

# tlp
sudo pamac install tlp tlpui
tlp_conf="${SETUP_DIR}/global/data/etc/tlp.conf"
if [[ -f "${tlp_conf}-local_$(hostname)" ]]; then
    tlp_conf="${tlp_conf}-local_$(hostname)"
fi
if [[ -f "$tlp_conf" ]]; then
    sudo cp $tlp_conf /etc/tlp.conf
    sudo chown root:root /etc/tlp.conf
    sudo chmod 0644 /etc/tlp.conf
fi
sudo systemctl enable --now tlp

# thermald
sudo pamac install thermald
sudo systemctl enable --now thermald
if [[ ! $(getent group power) ]]; then
    sudo groupadd power && sudo gpasswd -a $USER power
fi

# configure SDDM to use Wayland
source_file="${SETUP_DIR}/global/data/etc/sddm.conf.d/10-wayland.conf"
sudo cp $source_file /etc/sddm.conf.d/10-wayland.conf
sudo chown root:root /etc/sddm.conf.d/10-wayland.conf
sudo chmod 0644 /etc/sddm.conf.d/10-wayland.conf
