#!/usr/bin/bash

enable_start_service() {
    [ $# -eq 1 ] && service="$1"
    [ $# -lt 1 ] && echo "Error: no argument specified." >&2 && return 1
    [ $# -gt 1 ] && echo "Error: too many arguments." >&2 && return 1

    if ! systemctl -q is-enabled "$service"; then
        echo "Enabling $service..."
        if ! $sudo systemctl enable "$service" >/dev/null; then
            echo "Failed to enable $service" >&2
            return 1
        fi
    fi

    if ! systemctl -q is-active "$service"; then
        echo "Starting $service..."
        if ! $sudo systemctl start "$service" >/dev/null; then
            echo "Failed to start $service" >&2
            return 1
        fi
    fi
}

enable_start_service_user() {
    [ $# -eq 1 ] && service="$1"
    [ $# -lt 1 ] && echo "Error: no argument specified." >&2 && return 1
    [ $# -gt 1 ] && echo "Error: too many arguments." >&2 && return 1

    if ! systemctl --user -q is-enabled "$service"; then
        echo "Enabling $service..."
        if ! $sudo systemctl --user enable "$service" >/dev/null; then
            echo "Failed to enable $service" >&2
            return 1
        fi
    fi

    if ! systemctl --user -q is-active "$service"; then
        echo "Starting $service..."
        if ! $sudo systemctl --user start "$service" >/dev/null; then
            echo "Failed to start $service" >&2
            return 1
        fi
    fi
}
