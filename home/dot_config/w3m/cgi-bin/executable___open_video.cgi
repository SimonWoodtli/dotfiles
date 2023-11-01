#!/usr/bin/sh
# EXTERN_LINK = under cursor
# EXTERN      = current page
echo "W3m-control: BACK"
echo "W3m-control: EXTERN_LINK TS_SOCKET=/tmp/w3m ts mpv --ontop --no-border --force-window --autofit=500x280 --geometry=-15-53"
