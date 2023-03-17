#!/usr/bin/sh
echo "w3m-control: READ_SHELL curl -s dict://dict.org/d:$QUERY_STRING"
echo "w3m-control: DELETE_PREVBUF"
echo "w3m-control: REDRAW"
