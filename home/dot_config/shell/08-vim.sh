
################################## VIM #################################

## vi-mode for shell
set -o vi

_have vi && export EDITOR=vi; export VISUAL=vi; export EDITOR_PREFIX=vi;
_have vim && export EDITOR=vim; export VISUAL=vim; export EDITOR_PREFIX=vim;

[[ -d $HOME/.vim/spell ]] && export VIMSPELL=("$HOME/.vim/spell/*.add")
