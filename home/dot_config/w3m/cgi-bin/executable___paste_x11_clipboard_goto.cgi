#!/usr/bin/sh
echo "W3m-control: SET_OPTION default_url=0"
echo "W3m-control: GOTO $(xclip -o -selection clipboard)"
echo "W3m-control: DELETE_PREVBUF"
echo "W3m-control: SET_OPTION default_url=1"
