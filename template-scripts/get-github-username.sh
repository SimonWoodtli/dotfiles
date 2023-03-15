#!/bin/sh
remoteUrl=$(chezmoi git -- config --get remote.origin.url)
# filter username from url
githubUsername=${remoteUrl%/*}
githubUsername=${githubUsername##*:}

echo "$githubUsername"
