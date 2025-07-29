#!/bin/bash

list=$(ssh maxi@home-server.com -t "find /home/maxi/sambashare/roms -type f | fzf --filter='$1' | head -n 10 | tr '\n' ':'")
list=$(echo ":"."$list")
list=$(echo "$list" | sed 's/:[^:_]*roms\//:/g')
list=$(echo $list | sed 's/:/\n/g')

result=$(echo "$list" | fzf )

if [ -z "$result" ]; then
  echo "No file selected."
  exit 1
fi

targetName=$(echo "$result" | sed 's/_duplicados\///')

echo $targetName

scp maxi@home-server.com:"/home/maxi/sambashare/roms/$result" root@192.168.1.73:"/mnt/mmc/ROMS/$targetName"

# scp root@192.168.1.73:"/mnt/mmc/ROMS/"
