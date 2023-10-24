#!/usr/bin/sh
## Any command that requires the 2nd variable line from /tmp/w3m-buffer needs 
## to grab it directly from within it's own script in ~/config/w3m/cgi-bin
## => can't pass variables from child to parent
#
## The execute script only targets the 1st line from /tmp/w3m-buffer with either 
## the script name, http path or built-in w3m command
selectScript="$(sed -e '2d' /tmp/w3m-buffer)"
case "$selectScript" in
  *.cgi)  echo "W3m-control: GOTO file:/cgi-bin/$selectScript" ;;
  http://*|https://*|www.*|gopher://*|gemini://*)  echo "W3m-control: TAB_GOTO $selectScript" ;;
  /*|\~/*)  echo "W3m-control: TAB_GOTO $selectScript" ;;
  *)  echo "W3m-control: $selectScript" ;;
esac
