#!/usr/bin/bash

configure_pacman_mirrors() {
    mirrors=("$(echo "$@" | tr ' ' '\n' | sort)")
    mirrors_current=("$(pacman-mirrors -lc | sort)")

    if [ "${mirrors[*]}" != "${mirrors_current[*]}" ]; then
        echo "Desired mirrors: ${mirrors[*]}"
        echo "Current mirrors: ${mirrors_current[*]}"
        mirrors_formatted=$(
            IFS=,
            echo "$*"
        )
        echo "Setting pacman-mirrors countries to ${mirrors_formatted[*]}"
        $sudo pacman-mirrors -c "${mirrors_formatted}"
    fi
}
