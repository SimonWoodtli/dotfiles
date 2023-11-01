#!/usr/bin/sh
# mpv allows to view gif too
## Important EXTERN_LINK ony works if the image is an actual link,
## In other words gotta be able to jump to it with J/K
## Otherwise you need either a terminal with image support to toggle
## Or use IMAGE_VIEW
## EXTERN_LINK = under cursor, EXTERN = current page
echo "W3m-control: BACK"
echo "W3m-control: EXTERN_LINK TS_SOCKET=/tmp/w3m ts mpv --loop --ontop --no-border --force-window --autofit=500x280 --geometry=-15-53"
