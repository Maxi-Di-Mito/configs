#!/bin/bash

# Get all changed files and select through fzf with preview
selected_files=$(git status -s | sed s/^...// | fzf --multi --tmux 80% --preview "bat --color=always {}")


echo $selected_files

