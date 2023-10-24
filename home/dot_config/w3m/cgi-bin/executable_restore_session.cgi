#!/usr/bin/sh
## location of generated script of last session
RESTORE_SESSSION="$HOME/.local/bin/w3mlastsession"

## generate `w3mlastsession` script: add header
echo "#!/usr/bin/sh" > "$RESTORE_SESSSION"
echo "w3m -N \\" >> "$RESTORE_SESSSION"

## generate `w3mlastsession` script:
## remove dupes without sorting and append trailing slash to each url
awk '!x[$0]++' "$XDG_CONFIG_HOME/w3m/RestoreSession.txt" | while read -r line ; do echo "'$line' \\" >> "$RESTORE_SESSSION" ; done

## generate `w3mlastsession` script:
## remove last trailing slash of the last line
sed -i '$ s-.$--' "$RESTORE_SESSSION"

chmod +x "$RESTORE_SESSSION"

## OUTPUT SCRIPT FILE EXAMPLE ~/.local/bin/w3mlastsession
## --------------------------------------------------
##  #!/usr/bin/sh
##  w3m -N \
##  'https://www.reddit.com/r/w3m/.mobile' \
##  'https://www.reddit.com/r/commandline/.mobile' \
##  'https://www.reddit.com/r/linux/.mobile' \
##  'http://lite.cnn.com/en' \
##  'https://raw.githubusercontent.com/tats/w3m/master/ChangeLog' \
##  'https://github.com/gotbletu/shownotes'
## --------------------------------------------------

