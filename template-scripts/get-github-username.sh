#!/bin/sh
#remoteUrl=$(chezmoi git -- config --get remote.origin.url)
filepath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
remoteUrl=$(git -C "$filepath" config --get remote.origin.url)
# filter username from url
githubUsername=${remoteUrl%/*}
githubUsername=${githubUsername##*:}

echo "$githubUsername"
