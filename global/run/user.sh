#!/usr/bin/bash

SETUP_DIR=${SETUP_DIR:-$HOME/linux-setup}

source_file="${SETUP_DIR}/global/data/home/daniel/.aliases"
cp $source_file /home/daniel/.aliases
if [[ -f "${source_file}-local_$(hostname)" ]]; then
    source_file="${source_file}-local_$(hostname)
    cp $source_file /home/daniel/.aliases-local_$(hostname)

source_file="${SETUP_DIR}/global/data/home/daniel/.profile"
cp $source_file /home/daniel/.profile
if [[ -f "${source_file}-local_$(hostname)" ]]; then
    source_file="${source_file}-local_$(hostname)
    cp $source_file /home/daniel/.profile-local_$(hostname)

source_file="${SETUP_DIR}/global/data/home/daniel/.gitconfig"
cp $source_file /home/daniel/.gitconfig
