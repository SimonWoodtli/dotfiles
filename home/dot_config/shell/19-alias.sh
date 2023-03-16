
############################## All Aliases #############################
#      (use exec scripts instead, which work from vim and subprocs)

unalias -a
alias more='less -R'
alias clear='printf "\e[H\e[2J"'
alias c="printf  $'\033[2J\033[;H'" # clear
alias mv='mv -n' # sets noclobber: moving existing files won't get deleted
alias egrep='egrep -i --colour=auto'
alias fgrep='fgrep -i --colour=auto'
alias grep='fgrep -i --colour=auto'
alias sudo='sudo '
alias visudo='EDITOR=/usr/bin/vim visudo'
alias free='free -h'
alias df='df -h'
alias syserrors="sudo journalctl -p 3 -xb"
alias sysderrors="sudo systemctl --failed"
alias chmox="chmod u+x"
alias tree='broot'
alias cp='cp -v'
alias ip='ip -c'
alias cm='chezmoi'
alias dot="cd $HOME/.local/share/chezmoi/home"

#_have pcregrep && alias grep='pcregrep' || alias grep='grep -i --colour=auto'
_have dnf && alias dnf="dnf -C"
_have youtube-dl && alias yt-dl='youtube-dl'
_have duf && alias df='duf'
_have bat && alias bat='bat --theme gruvbox-dark'
_have bat && alias cat='bat --theme gruvbox-dark'
_have rg && alias rg='rg --ignore-case --column --line-number --no-heading --color=always'
_have curl && alias curl='curl -L'
_have dust && alias du='dust'
_have vim && alias vi='vim'
_have emacs && alias emacs='emacsclient -c -a "emacs"'
_have emacs && alias emac='emacsclient --tty'
_have neomutt && alias mutt='neomutt'
_have libreoffice && alias doc='libreoffice'
_have mupdf && alias mupdf='mupdf -I'
_have vlc && alias vlc='/usr/bin/vlc'
_have neo && alias neo='neo -a -D -c green'
_have bashtop && alias top='bashtop'
_have browser-sync && alias browsersync='browser-sync start --server --files "*.html, \
  css/*.css"'
_have reddio && alias ra='reddio | boxes -d dog | less'
_have spotify && alias spotify="env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify %U &"
_have speedtest-cli && alias speedtest='speedtest-cli --secure'
alias app="env APPIMAGELAUNCHER_DISABLE=1 $HOME/Applications/app"

alias s=searx
alias ?=duck
alias ??=stackexchange
alias ipinfo="curl ipinfo.io"
alias rec='asciinema rec'

############################ ALIAS GIT ########################################
## if $git rm -r is not enough:
alias gri='git ls-files --ignored --exclude-standard | xargs -0 git rm -r'
alias ga='git add'
alias gs='git status'
alias gpl='git pull'
alias gps='git push'
alias gc='git commit'
alias gg='git graph'
alias gview='git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s" --simplify-by-decoration'
alias gbigfiles='git rev-list --all | xargs -rL1 git ls-tree -r --long | sort -uk3 | sort -rnk4 | less'
alias gd='git diff'
alias gsu='git stash && git pull && git stash pop'
alias gdl='git log --diff-filter=D --summary | grep delete'
alias fgck='git branch | fzf | xargs git checkout'

############################## ALIAS LS #######################################
alias ls='ls -h --color=auto'
alias lsplain='ls -h --color=never'
alias lx='ls -AlXB'    #  Sort by extension.
alias lxr='ls -ARlXB'  #  Sort by extension.
alias lk='ls -AlSr'    #  Sort by size, biggest last.
alias lkr='ls -ARlSr'  #  Sort by size, biggest last.
alias lt='ls -Altr'    #  Sort by date, most recent last.
alias ltr='ls -ARltr'  #  Sort by date, most recent last.
alias lc='ls -Altcr'   #  Sort by change time, most recent last.
alias lcr='ls -ARltcr' #  Sort by change time, most recent last.
alias lu='ls -Altur'   #  Sort by access time, most recent last.
alias lur='ls -ARltur' #  Sort by access time, most recent last.
alias ll='ls -Alhv'    #  A better long listing.
alias llr='ls -ARlhv'  #  Recursive long listing.
alias lr='ll -AR'      #  Recursive simple ls.
alias lm='ls |more'    #  Pipe through 'more'
alias lmr='lr |more'   #  Pipe through 'more'
