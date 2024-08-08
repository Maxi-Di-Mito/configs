#!/usr/bin/env bash
SELECTED_BRANCH=`git branch -a | cat | fzf`

branch=`echo $SELECTED_BRANCH | tr ' ' ''`

git checkout $branch
