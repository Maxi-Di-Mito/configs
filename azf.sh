echo $(ag --hidden --ignore .git --path-to-ignore ~/configs/.ignore -g "" | fzf --preview 'bat --color=always --style=header,grid --line-range :400 {}')
