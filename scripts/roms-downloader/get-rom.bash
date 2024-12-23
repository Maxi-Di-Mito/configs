#!/usr/bin/env bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

console=$(ls -a "$parent_path/files/" | cat | fzf --tmux 70%)
selected=$(cat "$parent_path/files/$console" | fzf --tmux 70%)

name=$(echo $selected | cut -f1 -d=)
url=$(echo $selected | cut -f2 -d=)
url="${url%' *Size'}"
size=$(echo $selected | cut -f3 -d=)

echo "$name : SIZE: $size"

if [ $# -eq 0 ]                                 
  then                                          
    downloadPath="."
  else                                            
    downloadPath=$1                                  
fi                                              


read -r -p "Download to $downloadPath ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  curl -o "$downloadPath/$name" "$url"
fi

echo "\nFinished\n"
read -r cosa
