
############################### FUNCTIONS ##############################

############################# zet commands #############################
cdz () { cd "$(zet get "$@")"; }
zb() {
  cd "$GHREPOS/zet"
  #local file="$(git log | fzf | sed 's/^ *//')"
  vi "$(rg -l "$(git log | fzf | sed 's/^ *//')")"

  #vi "$(rg -l "$(git log | fzf | sed 's/^ *//')")"
}

kill9() {
  ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}

ze() {
  zet edit "$1"
}
zc() {
  zet create "$1"
}
zu() {
  zet use "$1"
}
########################## fzf ctrl-r history ##########################
__fzfcmd() {                                                                    
  [[ -n "$TMUX_PANE" ]] && { [[ "${FZF_TMUX:-0}" != 0 ]] || [[ -n "$FZF_TMUX_OPTS" ]]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
} 
history() {                                                                
  local output opts script                                                         
  opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS -n2..,.. --scheme=history --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m --read0"
  script='BEGIN { getc; $/ = "\n\t"; $HISTCOUNT = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCOUNT - $. . "\t$_" if !$seen{$_}++'
  output=$(                                                                        
    builtin fc -lnr -2147483648 |                                                  
      last_hist=$(HISTTIMEFORMAT='' builtin history 1) perl -n -l0 -e "$script" |
      FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) --query "$READLINE_LINE"                
  ) || return                                                                      
  READLINE_LINE=${output#*$'\t'}                                                   
  if [[ -z "$READLINE_POINT" ]]; then                                              
    echo "$READLINE_LINE"                                                          
  else                                                                             
    READLINE_POINT=0x7fffffff                                                      
  fi                                                                               
}
# CTRL-R - Paste the selected command from history into the command line
# Since Ctrl-R already is a command in many terminals to view history I'm
# fine with this
bind -m emacs-standard -x '"\C-r": history'
bind -m vi-command -x '"\C-r": history'
bind -m vi-insert -x '"\C-r": history'
############################# fzf commands #############################
# https://git.sr.ht/~mlaparie/passfzf
ftags() {
# ftags - search ctags with preview
# only works if tags-file was generated with --excmd=number
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    fzf \
      --nth=1,2 \
      --with-nth=2 \
      --preview-window="50%" \
      --preview="bat {3} --color=always | tail -n +\$(echo {4} | tr -d \";\\\"\")"
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}
fvic() {
  ## fuzzy vic but only on $SCRIPTS. Not on every program like vic: `vi `which $1``
  fd --type f . $SCRIPTS | fzf | xargs -o vim
  #\du -a $SCRIPTS | awk '{print $2}' | fzf | xargs -o vim
  #ls -R $SCRIPTS | fzf | xargs -o vim
}
fcat() {
  ## fuzzy cat to search through file
  local FZF_DEFAULT_OPTS="--layout=reverse --info=inline"
  cat "$1" | fzf
}
# intersting code snippet but I don't need. I got `open` and regular
# `fzf` with keybindings
#fzfopen() {
#  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
#  key=$(head -1 <<< "$out")
#  file=$(head -2 <<< "$out" | tail -1)
#  if [ -n "$file" ]; then
#    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
#  fi
#}
fvi() {
  ## if you want to open all the files related to a project in different
  ## vim buffers, fuzzy search them and tab to mark files
  vim $(fzf)
}

fo() {
  ## fuzzy open only from current dir in vim
  fd --max-depth 1 --type f . "$PWD" | fzf | xargs -o vim
}
frm() {
  ## fuzzy remove selected files (select multiple files with tab)
  rm -rf "$(ls | fzf -m)"
}
fpath() {
  ## fuzzy search files and copy its path to x11 xlipboard
  fd -a --type f | fzf | tr -d '\n' | xclip -sel clip
}

frg() {
  ##TODO how to get FZF to use RG instead of fd so you can search within
  #files > like the fzf vimplugin command :Rg
  #local FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}"'
  #local FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
  ## fuzzy search with ripgrep
  echo $FZF_DEFAULT_COMMAND
  #rg "$1" | fzf
  #echo $1 | fzf
}

fcd() {
  ## fuzzy search dir and cd into it
  cd "$(fd --type d | fzf)"
}

pythonv() {
  ##TODO make function with arguments to create/activate virtenv
  ## create virtual env. called tutorial-env
  #python3 -m venv tutorial-env
  # activate/source project folder with all virtual environments and select
  # project with fzf
  local selected_env
  selected_env=$(ls ~/.venv/ | fzf)

  if [ -n "$selected_env" ]; then
    source "$HOME/.venv/$selected_env/bin/activate"
  fi
}

############################# fzf with git #############################

##many of my git aliases can now be used with fzf, thanks to:
##this awesome tool:https://github.com/wfxr/forgit

gdb() {
  ## select branches with tab to be deleted
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log {} --" |
    xargs --no-run-if-empty git branch --delete --force
}

gprck() {
  ## git search pullrequests and checkout selected
  local FZF_DEFAULT_OPTS="--layout=reverse --info=inline --bind ctrl-/:toggle-preview"
  local jq_template pr_number

  jq_template='"'\
'#\(.number) - \(.title)'\
'\t'\
'Author: \(.user.login)\n'\
'Created: \(.created_at)\n'\
'Updated: \(.updated_at)\n\n'\
'\(.body)'\
'"'

  pr_number=$(
    gh api 'repos/:owner/:repo/pulls' |
    jq ".[] | $jq_template" |
    sed -e 's/"\(.*\)"/\1/' -e 's/\\t/\t/' |
    fzf \
      --with-nth=1 \
      --delimiter='\t' \
      --preview='echo -e {2}' \
      --preview-window=top:wrap |
    sed 's/^#\([0-9]\+\).*/\1/'
  )

  if [ -n "$pr_number" ]; then
    gh pr checkout "$pr_number"
  fi
}

################################# stuff ################################
temp() { cd "$(mktemp -d)"; }
cpr() { rsync --progress -auv "$1" "$2"; }
##TODO make a case so you can select what kind of comment you want to
##remove
rmc() { sed 's|\s*#.*||g; /^$/ d' "$1" > "$2"; } #rm hashtag comment and empty line
################################ prompt ################################
miniprompt() {
  unset PROMPT_COMMAND
  PS1="\[\e[38;5;168m\]$ \[\e[0m\]"
}
################################## git #################################
#
gcr() {
  echo 'gh repo create nameOfProject --description "🌍 a brief description example" --public --source=. --remote=upstream --push' | tr -d "\n" | xclip -sel clip
  echo 'gh repo create nameOfProject --description "🌍 a brief description example" --public --source=. --remote=upstream --push'
}

gvi() {
  ## $1 is an URL to an issue like https://github.com/cli/cli/issues/1055
  ##TODO find a way to grab to URL from CLI
  gh issue view --comments $1
}
clone() {
  local repo="$1" user
  local repo="${repo#https://github.com/}"
  local repo="${repo#git@github.com:}"
  if [[ $repo =~ / ]]; then
    user="${repo%%/*}"
  else
    user="$GITUSER"
    [[ -z "$user" ]] && user="$USER"
  fi
  local name="${repo##*/}"
  local userd="$REPOS/github.com/$user"
  local path="$userd/$name"
  [[ -d "$path" ]] && cd "$path" && return
  mkdir -p "$userd"
  cd "$userd"
  echo gh repo clone "$user/$name" -- --recurse-submodule
  gh repo clone "$user/$name" -- --recurse-submodule
  cd "$name"
} && export -f clone

################################## env #################################
envx() {
  local envfile="${1:-"$HOME/.env"}"
  [[ ! -e "$envfile" ]] && echo "$envfile not found" && return 1
  while IFS= read -r line; do
    name=${line%%=*}
    value=${line#*=}
    [[ -z "${name}" || $name =~ ^# ]] && continue
    export "$name"="$value"
  done < "$envfile"
} && export -f envx
[[ -e "$HOME/.env" ]] && envx "$HOME/.env"

