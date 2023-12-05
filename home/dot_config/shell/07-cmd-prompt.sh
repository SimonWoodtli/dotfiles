
############################## CMD PROMPT ##############################

## http://mywiki.wooledge.org/BashFAQ/053
##TODO if PS1 too long make it two lines
__ps1() {
  local p='\e[0;35m' # Purple
  local cr='\e[0;36m' # Cyan => main Red
  local br='\e[0;34m' # Blue -> root Red
  local b='\e[0;34m' # Blue
  local r='\e[0;31m' # Red
  local yr='\e[0;33m' # Yellow -> root Red
  local d='\e[38;2;110;110;110m' # Dark
  local x='\e[0m'    # Text Reset
  local P='$'        # prompt end $/#
  #branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/') #complicated get branch name + ()
  local branch=$(git branch --show-current 2> /dev/null) #store branch name
  ## Problem: /home/user/.basrc does not get read by root
  ## Solution: add this to /root/.bashrc: source /home/sero/Repos/github.com/SimonWoodtli/dotfiles/bin/shell/cmd-prompt.sh
  [[ $EUID == 0 ]] && P='#' && yr=$r && br=$r #check if root and change color
  [[ $branch = master || $branch = main ]] && cr="$r" #change branch to red
  [[ $branch != master && $branch != main ]] && cr='\e[0;36m' #change branch to cyan
  [[ -n "$branch" ]] && branch="\[$d\](\[$cr\]$branch\[$d\])" #if branch exist add parenthesis and branchname
  ## PS1 explained:
  # \u = user \h = host \W = current dir (\w = current dir + path)
  ## ANSI Colors need to be wrapped/escaped \[...\]
  ## @,: is hardcoded => no escape

   ## $branch, $P are variables that change depending on whether git repo or root => no escape
   export PS1="\[$yr\]\u\[$d\]@\[$b\]\h\[$d\]:\[$p\]\W$branch\[$br\]$P\[$x\] " #defaultp prompt has no (git-branch-name)
   #always prints new line: e.g `printf foo` prints foo on new line
   #export PS1="$(printf "%$((`tput cols` -1))s\r")\[$yr\]\u\[$d\]@\[$b\]\h\[$d\]:\[$p\]\W$branch\[$br\]$P\[$x\] " #defaultp prompt has no (git-branch-name)
}

export PROMPT_COMMAND="__ps1"
