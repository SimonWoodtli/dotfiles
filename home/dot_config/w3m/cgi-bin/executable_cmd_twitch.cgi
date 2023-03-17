#!/usr/bin/sh
QUERY_STRING="${QUERY_STRING//+/%20}"
echo "w3m-control: BACK"
## search for specific streamer
echo "w3m-control: TAB_GOTO https://m.twitch.tv/$QUERY_STRING"
## search for game/category
#echo "w3m-control: TAB_GOTO https://m.twitch.tv/directory/game/$QUERY_STRING"
