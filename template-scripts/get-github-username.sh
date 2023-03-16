#!/bin/sh
# I currently have no use for this script. As My chezmoi git repo is
# already in a path which requires the git username. There is no way I
# will use the default ~/.local/share/chezmoi repo path. As it would
# break many scripts and exported variables. 
#remoteUrl=$(chezmoi git -- config --get remote.origin.url)
filepath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
remoteUrl=$(git -C "$filepath" config --get remote.origin.url)
# filter username from url
githubUsername=${remoteUrl%/*}
githubUsername=${githubUsername##*:}

echo "$githubUsername"

# A hardcoded path with the username is useless
# Also I tried on a fresh machine to initialize and apply `chezmoi -S
# pathToDotRepo init --apply urlToRepo` but that still requires a `exec
# bash -l` so reading env. variables set in the bashrc is impossible.
#template code:{{- $gituser = output "bash" "-c" "$HOME/Repos/github.com/SimonWoodtli/dotfiles/template-scripts/get-github-username.sh" | trim -}}{{/* exec external script*/}}
#
# My current idea:
# Have Interactive setups where promptString can be utilized
# Have non-interactive setups where promptString needs to be passed in
# the primary `chezmoi init` cmd.
# 
# Non-interactive:
# Since I want to fetch this repo and install chezmoi in a workspace
# docker container I need to build that image with the steps to do so.
