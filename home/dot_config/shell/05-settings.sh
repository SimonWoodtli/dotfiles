
############################### SETTINGS ###############################

## globstar: (ls **filename includes subdirectories):
#set -o noclobber            # paranoid? use >| for everything
shopt -s expand_aliases
shopt -s globstar # globbing with ** matches all files and dir/subdirs
shopt -s dotglob # using the * to `mv` etc. includes .files
shopt -s extglob # enable extended pattern matching in path name expansions
shopt -s histappend # append history instead of overwritting
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s histappend # do not overwrite history
shopt -s checkwinsize # checks term size when bash regains control
#shopt -s nullglob # creates bug FIX ME

export HISTCONTROL=ignoreboth:erasedups # Ignore duplicates in command history
export HISTSIZE=5000 # increase default 500 commands to 5000
export HISTFILESIZE=10001
## unlimited history
#export HISTSIZE=
#export HISTFILESIZE=
## Change the file location because certain bash sessions truncate .bash_history file upon close.
#export HISTFILE=$HOME/.bash_eternal_history

export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
# Force prompt to write history after every command.
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#setxkbmap -option ctrl:ctrl_modifier # map capslock to control
export HRULEWIDTH=73

## fetch fancy git prompt, not needed with current prompt => bloat
#_source_if "$DOTFILES/bin/shell/additional/git-prompt.sh"
