#!/usr/bin/sh
## script to save current tabs into RestoreSession.txt and then exit w3m
## while saving it into `w3mlastsession`
echo "W3m-control: BACK"
saving_session="$XDG_CONFIG_HOME/w3m/RestoreSession.txt"
echo "W3m-control: EXTERN echo %s > $saving_session"
## loop save URL of all tabs
n=0
while [ "$n" -lt 30 ]; do
  n=$(( n + 1 ))
  echo "W3m-control: NEXT_TAB"
  echo "W3m-control: EXTERN echo %s >> $saving_session"
done
## generate `w3mlastsession` script: run 'w3mlastsession' command in terminal to restore session
echo "W3m-control: READ_SHELL ~/.config/w3m/cgi-bin/restore_session.cgi"
echo "W3m-control: BACK"
echo "W3m-control: QUIT"
