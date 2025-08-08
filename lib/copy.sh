#!/usr/bin/bash

true # this prevents shellcheck from applying the directive to the whole file

#shellcheck disable=2086
copy() {
    __usage="
    usage: $(basename $0) source destination [OPTIONS]

    Options:
      --mode     : target file permissions in octal form, given to chmod
      --owner    : target owner name, given to chown
      --group    : target group name, given to chgrp
    "

    if [ $# -ge 2 ]; then
        source=$1
        target=$2
        shift 2
    else
        echo "Error: source or destination missing!" >&2
        echo "$__usage"
        return 1
    fi

    while [ $# -gt 0 ]; do
        case "$1" in
        --mode=*)
            mode="${1#*=}"
            ;;
        --owner=*)
            owner="${1#*=}"
            ;;
        --group=*)
            group="${1#*=}"
            ;;
        *)
            printf "Error: Invalid argument: %s\n" "$1" >&2
            return 1
            ;;
        esac
        shift
    done

    if ! [ -f "$source" ]; then
        echo "Error: source file doesn't exist!" >&2
        echo "File path: $source"
        return 1
    fi

    need_copy=0

    if [ -f "$target" ]; then
        cmp -s "$source" "$target"
        [ $? -eq 1 ] && need_copy=1
    else
        need_copy=1
        target_dir="$(dirname "$target")"
        ! [ -d "$target_dir" ] && mkdir -p "$target_dir"
    fi

    if [ "$need_copy" != 0 ]; then
        echo "Copying $source to $target."
        cp "$source" "$target" || return 1
    fi
    [ $? -eq 2 ] && return 1

    if [ -n "$mode" ] && [ "$(stat -c "%a" "$target")" != "$mode" ]; then
        echo "Setting mode $mode on $target."
        chmod "$mode" "$target" || return 1
    fi

    if [ -n "$owner" ] && [ "$(stat -c "%U" "$target")" != "$owner" ]; then
        echo "Setting owner $owner on $target."
        chown "$owner" "$target" || return 1
    fi

    if [ -n "$group" ] && [ "$(stat -c "%G" "$target")" != "$group" ]; then
        echo "Setting group $group on $target."
        chgrp "$group" "$target" || return 1
    fi

    if [ "$need_copy" -eq 1 ]; then
        return 9
    fi
}
