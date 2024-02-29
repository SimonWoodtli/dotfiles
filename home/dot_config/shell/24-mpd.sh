
################################## MPD #################################

# MPD daemon start (if no other user instance exists)
[ -s "$HOME/.config/mpd/pid" ] || mpd
