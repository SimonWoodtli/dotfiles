#!/usr/bin/sh
# EXTERN_LINK / $W3M_CURRENT_LINK = under cursor
# EXTERN / $W3M_URL               = current page
echo "W3m-control: BACK"
url="$W3M_URL"
_have() { type "$1" >/dev/null; }
printf "%b" "$url" > /tmp/clipbrd.txt
_have xclip && printf "%b" "$url" | xclip -sel clipboard -loops 0 >/dev/null
_have tmux && printf "%b" "$url" | tmux load-buffer - 2>/dev/null
_have termux-info && printf '%b' "$url" | termux-clipboard-set 2>/dev/null
#_have wl-copy && printf '%b' "$url" | wl-copy 2>/dev/null
#_have clip && printf '%b' "$url" | clip 2>/dev/null
#printf '%b' "$url" > /dev/clipboard 2>/dev/null
#_have pbcopy && printf '%b' "$url" | pbcopy 2>/dev/null
#_have xsel && printf "%b" "$url" | xsel -b 2>/dev/null
