#!/usr/bin/env bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
console=$(ls -a "$parent_path/files/" | cat | fzf --tmux 70%)
selected=$(cat "$parent_path/files/$console" | fzf --tmux 70%)

name=$(echo $selected | cut -f1 -d=)
url=$(echo $selected | cut -f2 -d=)
url="${url%' *Size'}"
size=$(echo $selected | cut -f3 -d=)

echo "$name : SIZE: $size"
read -p "Download? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
curl -o "$name" "$url"