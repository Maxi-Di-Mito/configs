# this is what matters
# FZF_COMMON_OPTIONS="
#   --bind='?:toggle-preview'
#   --bind='ctrl-u:preview-page-up'
#   --bind='ctrl-d:preview-page-down'
#   --preview-window 'right:60%:hidden:wrap'
#   --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat --style=full --color=always {}) || echo {}'"



fzf --tmux 80% --preview "( [[ -d {} ]] && tree -C {} ) || ( chafa {} ) || bat --style=full --color=always {}"
