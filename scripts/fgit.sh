#!/bin/bash

# Use FZF to select files
selected_files=$(git ls-files -co | fzf --multi --tmux 70% --preview "bat --color=always {}")

# If no files were selected, exit
if [[ -z "$selected_files" ]]; then
    echo "No files selected."
    exit 0
fi

# Use FZF to select a Git command
selected_command=$(echo -e "add\nrm\ncheckout\nreset\ndiff\n" | fzf +m --tmux 70% --preview "echo {}")



# If no command was selected, exit
if [[ -z "$selected_command" ]]; then
    echo "No Git command selected."
    exit 0
fi

# Execute the selected Git command with the selected files
case "$selected_command" in
    add)
        git add $selected_files
        ;;
    rm)
        git rm $selected_files
        ;;
    checkout)
        git checkout $selected_files
        ;;
    reset)
        git reset $selected_files
        ;;
    diff)
        git diff $selected_files
        ;;
    *)
        echo "Invalid command."
        ;;
esac
