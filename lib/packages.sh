#!/usr/bin/bash

###
# functions to implement

cmd_packages_list_installed() {
    echo "error: function 'cmd_packages_list_installed()' not implemented!" >&2
    exit 1
}

cmd_packages_check_not_installed() {
    echo "error: function 'cmd_packages_check_not_installed()' not implemented!" >&2
    exit 1
}

cmd_packages_install() {
    echo "error: function 'cmd_packages_install()' not implemented!" >&2
    exit 1
}

###
# import functions depending on distro
source "$SETUP_DIR/lib/$distro/packages.sh"

###
# general functions

cmd_packages_install_missing() {
    mapfile -t missing < <(cmd_packages_check_not_installed "$#")
    if [ -n "${missing[*]}" ]; then
        echo "Installing packages:"
        echo "$(
            IFS=', '
            echo "${missing[*]}"
        )"
        cmd_packages_install "${missing[@]}"
    fi
}
