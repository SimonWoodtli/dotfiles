#!/usr/bin/sh
# EXTERN_LINK = under cursor
# EXTERN      = current page
echo "W3m-control: BACK"
echo 'W3m-control: EXTERN_LINK TS_SOCKET=/tmp/download ts yt-dlp -o "~/Downloads/%(title)s.%(ext)s"'
