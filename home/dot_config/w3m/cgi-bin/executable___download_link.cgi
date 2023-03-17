#!/usr/bin/sh
# EXTERN_LINK = under cursor
# EXTERN      = current page
echo "W3m-control: BACK"
echo "W3m-control: EXTERN_LINK TS_SOCKET=/tmp/download tsp wget -c -P ~/Downloads"
