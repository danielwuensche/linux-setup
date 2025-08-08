#!/usr/bin/bash

[ -z "$(which jq)" ] && echo "'jq' not found, install 'jq' first." && exit 1

path_install="$HOME/apps"
path_install_buildfile="$path_install/Discord/resources/build_info.json"
path_install_exec="$path_install/Discord/Discord"
path_tmp="/tmp"
path_tmp_file="$path_tmp/discord.tar.gz"
url_download="https://discord.com/api/download?platform=linux&format=tar.gz"
url_api="https://discord.com/api/updates/stable?platform=linux"

get_version_local() {
    if ! [ -f "$path_install_buildfile" ]; then
        echo "Version file doesn't exist, assuming Discord isn't installed..." >&2
        exit 1
    fi

    version=$(jq .version "$path_install_buildfile")
    echo "$version"
}

get_version_upstream() {
    version=$(curl -s "$url_api" | jq .name)
    echo "$version"
}

discord_install() {
    [ -d "$path_install" ] || mkdir -p "$path_install"
    [ -d "$path_tmp" ] || mkdir -p "$path_tmp"

    wget -O "$path_tmp_file" "$url_download"
    cd "$path_install" || exit
    tar -xf "$path_tmp_file"

    rm "$path_tmp_file"
}

discord_run() {
    [ -f "$path_install_exec" ] && "$path_install_exec"
}

needs_install=0

version_local=$(get_version_local)
if [ -z "$version_local" ]; then
    needs_install=1
fi

if [ "$needs_install" -eq 0 ]; then
    version_upstream=$(get_version_upstream)
    if [ "$version_local" != "$version_upstream" ]; then
        needs_install=1
    fi
fi

if [ "$needs_install" -eq 1 ]; then
    discord_install
fi

discord_run
