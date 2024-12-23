#!/usr/bin/env bash
if [ $# -eq 0 ]
  then
    parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
else
parent_path=$1
fi

console=$(ls -a "$parent_path/files/" | cat | fzf --tmux 70%)
selected=$(cat "$parent_path/files/$console" | fzf --tmux 70%)

name=$(echo $selected | cut -f1 -d=)
url=$(echo $selected | cut -f2 -d=)
url="${url%' *Size'}"
size=$(echo $selected | cut -f3 -d=)

echo "$name : SIZE: $size"

read -r -p "Download? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  curl -o "$name" "$url"
fi

