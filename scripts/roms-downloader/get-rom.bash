#!/usr/bin/env bash
console=$(ls -a ./files/ | cat | fzf --tmux 70%)
selected=$(cat "files/$console" | fzf --tmux 70%)

name=$(echo $selected | cut -f1 -d=)
url=$(echo $selected | cut -f2 -d=)
url="${url%' *Size'}"
size=$(echo $selected | cut -f3 -d=)

curl -o "$name" "$url"
