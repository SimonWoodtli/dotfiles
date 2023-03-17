#!/usr/bin/sh
# EXTERN_LINK = under cursor
# EXTERN      = current page
# mpv allows to view gif too
echo "W3m-control: BACK"
echo "W3m-control: EXTERN_LINK TS_SOCKET=/tmp/w3m tsp mpv --loop --ontop --no-border --force-window --autofit=500x280 --geometry=-15-53"
