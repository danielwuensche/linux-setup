#!/usr/bin/bash

source "$SETUP_DIR/lib/enable_start_service.sh"

###

if pacman -Q | grep -w 'thermald' >/dev/null; then
    enable_start_service "thermald.service"
fi

if pacman -Q | grep -w 'intel-undervolt' >/dev/null; then
    enable_start_service "intel-undervolt.service"
fi

if pacman -Q | grep -w 'tuxedo-control-center' >/dev/null; then
    enable_start_service "tccd.service"
fi
