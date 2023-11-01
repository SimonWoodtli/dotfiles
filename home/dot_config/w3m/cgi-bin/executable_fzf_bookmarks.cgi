#!/usr/bin/sh
buffer=/tmp/w3m-buffer
selection=""
filterBookmarks() {
  sed '/^#.*#$/d' "$HOME/Private/bookmarks/work" | grep -v '^#'
}

## not running tmux
if [ "$TMUX_PANE" = "%0" ] || [ -z "$TMUX" ] || [ -z "$TERM_PROGRAM" ] ; then
  selection="$( filterBookmarks \
    | fzf --no-preview -i -e --prompt='bookmarks: ' \
    --info=default --layout=reverse --tiebreak=index)"
  [ -z "$selection" ] && echo "" > "$buffer" && exit
## tmux -ge 3.2 popup
elif [ "$TERM_PROGRAM" = tmux ] ; then
  selection="$( filterBookmarks \
    | fzf-tmux --no-preview -p -w 80% -h 70% -i -e --prompt='bookmarks:  '\
    | cut -d' ' -f1 | tr -d '\n' )"
  [ -z "$selection" ] && echo "" > "$buffer" && exit
## tmux -lt 3.2 regular split
elif [ -n "$TMUX" ] ; then
  selection="$( filterBookmarks \
    | fzf-tmux --no-preview -i -e --prompt='bookmarks: ' \
    --info=default --layout=reverse --tiebreak=index)"
  [ -z "$selection" ] && echo "" > "$buffer" && exit
fi
echo "$selection" > "$buffer"
