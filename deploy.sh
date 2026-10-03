#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH='' cd -P "$(dirname "$0")" && pwd -P)

symlink_file() {
    source_file=$SCRIPT_DIR/$1
    destination=$HOME/$2/$1
    destination_dir=$(dirname "$destination")

    if [ -L "$destination" ]; then
        printf '[WARNING] %s is already a symlink; leaving it unchanged\n' "$destination"
        return 0
    fi

    if [ -e "$destination" ]; then
        printf '[ERROR] %s exists and is not a symlink. Please resolve it manually.\n' "$destination" >&2
        return 1
    fi

    if [ ! -e "$source_file" ]; then
        printf '[ERROR] Source does not exist: %s\n' "$source_file" >&2
        return 1
    fi

    mkdir -p "$destination_dir"
    ln -s "$source_file" "$destination"
    printf '[OK] %s -> %s\n' "$source_file" "$destination"
}

deploy_manifest() {
    manifest=$1

    if [ ! -f "$manifest" ]; then
        printf '[ERROR] Manifest file not found: %s\n' "$manifest" >&2
        return 1
    fi

    while IFS='|' read -r filename operation destination ||
        [ -n "${filename:-}${operation:-}${destination:-}" ]; do
        case ${filename:-} in
        '' | \#*)
            continue
            ;;
        esac

        if [ -z "${operation:-}" ]; then
            printf '[ERROR] Invalid manifest row for %s: missing operation\n' "$filename" >&2
            return 1
        fi

        case $operation in
        symlink)
            symlink_file "$filename" "${destination:-}"
            ;;
        *)
            printf '[WARNING] Unknown operation %s. Skipping...\n' "$operation" >&2
            ;;
        esac
    done <"$manifest"
}

if [ "$#" -ne 1 ]; then
    printf 'Usage: %s <MANIFEST>\n' "$0" >&2
    if [ "$#" -eq 0 ]; then
        printf 'ERROR: no MANIFEST file was provided\n' >&2
    else
        printf 'ERROR: provide exactly one MANIFEST file\n' >&2
    fi
    exit 2
fi

case $1 in
/*) manifest=$1 ;;
*) manifest=$SCRIPT_DIR/$1 ;;
esac

deploy_manifest "$manifest"
