#!/usr/bin/bash

cmd_packages_list_installed() {
    pacman -Q | awk '{print $1}'
}

cmd_packages_check_not_installed() {
    installed=$(cmd_packages_list_installed)
    missing=()
    for p in $#; do
        matched_packages=$(echo "${installed[@]}" | grep -w "$p")
        [ -z "$matched_packages" ] && missing+=("$p")
    done
    echo "${missing[@]}"
}

cmd_packages_install() {
    $sudo pacman -S $#
}
