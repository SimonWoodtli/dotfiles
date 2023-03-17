#!/usr/bin/sh
#https://github.com/go-shiori/go-readability
# couldn't build go binary, maybe there is another readability tool
# written in go gotta research
echo "W3m-control: BACK"
echo "W3m-control: READ_SHELL go-readability -H $W3M_URL 2>/dev/null"
echo "W3m-control: VIEW"
echo "W3m-control: DELETE_PREVBUF"
