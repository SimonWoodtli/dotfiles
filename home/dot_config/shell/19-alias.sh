
############################## All Aliases #############################
#      (use exec scripts instead, which work from vim and subprocs)

unalias -a
alias more='less -R'
alias clear='printf "\e[H\e[2J"'
alias c="printf  $'\033[2J\033[;H'" # clear
alias mv='mv -n' # sets noclobber: moving existing files won't get deleted
alias ls='ls -h --color=auto'
alias cp='cp -v'
alias sudo='sudo '
alias diff='diff --color'
alias visudo='EDITOR=/usr/bin/vim visudo'
alias chmox="chmod u+x"
alias ip='ip -c'
alias dot="cd $DOTFILES"
alias scripts="cd $SCRIPTS"
alias deepl="proxychains deepl"
alias keepassxc='flatpak run --branch=stable --arch=x86_64 --command=keepassxc-cli org.keepassxc.KeePassXC'
alias mpv='flatpak run --branch=stable --arch=x86_64 io.mpv.Mpv'
alias diffside='diff --side-by-side --ignore-all-space'

alias ?=google
alias ??=duck
alias ???=searx

##hotfix for chezmoi sourcedir issue, need to figure out how to apply sourceDir from within container
alias cm='chezmoi -S /var/home/xnasero/Repos/github.com/SimonWoodtli/dotfiles init --apply'
#_have chezmoi && alias cm='chezmoi' && alias ce='chezmoi edit --apply'
#
#_have reddio && alias ra='reddio | boxes -d dog | less'
#_have spotify && alias spotify="env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify %U &"
#alias ipinfo="curl ipinfo.io"
_have pcregrep && alias grep='pcregrep' || alias grep='grep -i --colour=auto'
_have emacs && alias emacs='emacsclient -c -a "emacs"'
_have emacs && alias emac='emacsclient --tty'
_have abook && alias abook="abook -C $XDG_CONFIG_HOME/abook/abookrc --datafile $XDG_CONFIG_HOME/abook/addressbook"
_have bat && alias bat="bat --theme gruvbox-dark"
_have dnf && alias dnf="dnf -C"
_have youtube-dl && alias yt-dl='youtube-dl'
_have rg && alias rg='rg --ignore-case --column --line-number --no-heading --color=always'
_have curl && alias curl='curl -L'
_have dust && alias du='dust'
_have vim && alias vi='vim'
_have neomutt && alias mutt='neomutt'
_have libreoffice && alias doc='libreoffice'
_have mupdf && alias mupdf='mupdf -I'
_have vlc && alias vlc='/usr/bin/vlc'
_have neo && alias neo='neo -a -D -c green'
_have bashtop && alias top='bashtop'
_have browser-sync && alias browsersync='browser-sync start --server --files "*.html, \
  css/*.css"'
_have speedtest-cli && alias speedtest='speedtest-cli --secure'
_have asciinema && alias rec='asciinema rec'
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
