
############################ MANPAGES COLORS ###########################

## works on Debian, Arch

# export LESS_TERMCAP_mb=$magenta
# export LESS_TERMCAP_md=$yellow # effects title and commands
# export LESS_TERMCAP_me=$reset
# export LESS_TERMCAP_se=$reset
# export LESS_TERMCAP_so=$blue # effects search and bottom status line
# export LESS_TERMCAP_ue=$reset
# export LESS_TERMCAP_us=$underline # effects [options]...[file]

## Fedora doesn't seem to have /etc/termcap but only /etc/terminfo
## -> Check if Debian actually has /etc/terminfo if so you can select
## variables according to this file being on the system or not.

## works on any system:
## This works but creates a lot of subshells. However the hardcoded
## color code approach is only recommended if you only ever use your
## dotfiles on very few systems. Because the color codes at the top work
## for Debian/Arch but not Fedora. If I ever need to use more than two
## hardcoded variants I will use this approach.

# export LESS_TERMCAP_mb=$(tput bold; tput setaf 3) # yellow
# export LESS_TERMCAP_md=$(tput bold; tput setaf 3) # yellow
# export LESS_TERMCAP_me=$(tput sgr0)
# export LESS_TERMCAP_so=$(tput bold; tput setaf 4) # blue
# export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
# export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export LESS_TERMCAP_ZN=$(tput ssubm)
# export LESS_TERMCAP_ZV=$(tput rsubm)
# export LESS_TERMCAP_ZO=$(tput ssupm)
# export LESS_TERMCAP_ZW=$(tput rsupm)
# export GROFF_NO_SGR=1
# export LESS="--RAW-CONTROL-CHARS"

## works on Fedora
## Different colorcoding make it work
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;34m' # begin reverse video
export LESS_TERMCAP_us=$'\e[4;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

## Needed in Fedora, other Distros not sure
export MANPAGER='less -s -M +Gg' # show percentage in status line

## Further Info
#https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
#https://wiki.archlinux.org/title/Color_output_in_console
#https://unix.stackexchange.com/questions/119/colors-in-man-pages/329092#329092
