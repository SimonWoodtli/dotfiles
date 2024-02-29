
################################ EXPORTS ###############################

for dir in desktop documents downloads mnt music pictures private public \
  repos templates videos workspaces; do
  upper=${dir^^}
  cap=${dir^}
  if [ -d "$HOME/$cap" ]; then
    eval "export $upper='$HOME/$cap'"
  elif [ -d "$HOME/$dir" ]; then
    eval "export $upper='$HOME/$dir'"
  fi
done

if [ -e /run/.dockerenv ] || [ -e /run/.containerenv ]; then
  export CONTAINERENV=true
elif systemd-detect-virt --quiet --container; then
	export CONTAINERENV=true
fi
# Use Yubikey wtih PGP subkey for SSH, so replace SSH Agent with GPG Agent
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#export GPG_TTY=$(tty)
## gpg-agent should be started by systemd but we need to refresh the tty
#gpgsock=$(gpgconf --list-dirs agent-socket 2>/dev/null)
#if [[ -S $gpgsock ]]; then
	#gpg-connect-agent updatestartuptty /bye >/dev/null
#fi
#unset gpgsock

export TESTUSER="SimonWoodtli"
export USER="${USER:-$(whoami)}"
export BROWSER="$HOME/.local/bin/brave"
export VIRTUALMACHINES="$HOME/VirtualMachines"
export TERM=xterm-256color
_have git && export GITUSER="$(git config --global user.name)"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export SCRIPTS_PRIV="$PRIVATE/scripts"
export PDFDIR="$HOME/Documents/books/importantBooks" # used for `pdf` script
export PROMPT_COMMAND='history -a; history -r'
export CHEZMOI="$DOTFILES"
######################### XDG Dir Specification ########################
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_SHARE_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
######################## program|lang|frame|lib ########################
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
_have gpg && export GPG_TTY=$(tty)
_have ydotool && export YDOTOOL_SOCKET=/tmp/.ydotool_socket #no sudo/pw to use tool
_have nix && export NIX_BASH_COMPLETION="$(nix profile list | grep "bash-completion" | head -n 1 | awk '{print $4}')"
_have cargo && export CARGO_HOME="$XDG_DATA_HOME/cargo"
_have perl && export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"
_have docker && export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
_have docker && export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock
_have mbsync && export MBSYNCRC="$XDG_CONFIG_HOME/isync/mbsyncrc"
_have npm && export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
_have python && export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
_have rustup && export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
_have pass export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
_have w3m && export W3M_DIR="$XDG_CONFIG_HOME/w3m"
_have w3m && export WWW_HOME=https://lite.duckduckgo.com/lite
_have proxychains && export PROXYCHAINS_CONF_FILE="$XDG_CONFIG_HOME/proxychains/proxychains.conf"
_have cookiecutter && export COOKIECUTTER_CONFIG="$XDG_CONFIG_HOME/cookiecutter/??"
export ANSIBLE_INVENTORY="$XDG_CONFIG_HOME/ansible/ansible_hosts"
_have bat && export BAT_PAGER="less -R"
_have deno && export DENO_INSTALL_ROOT="$HOME/.local/deno/bin"
## IBUS config for chinese pinyin input
export GTK_IM_MODULE=IBUS
export XMODIFIERS=@im=IBUS
export QT_IM_MODULE=IBUS
################################## fzf #################################
#keybindingds: f2,f3,f4,.....
##TODO add f5 key binding to open with xdg-open
_have fzf && export FZF_DEFAULT_OPTS="--no-mouse --height 80% --layout=reverse --multi --info=inline --preview='$HOME/.vimplugins/fzf.vim/bin/preview.sh {}' --preview-window='right:60%:wrap' --bind='f2:toggle-preview,f3:execute(bat --style=numbers {} || less -f {}),f4:execute($EDITOR {}),alt-w:toggle-preview-wrap,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | pbcopy),ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"
_have fd && _have fzf && export FZF_DEFAULT_COMMAND='fd --type f --type l --hidden --follow --exclude .git'
## fzf comes with some keybindings, I don't wanna introduce bad muscle memory.
## CTRL commands are reserved for signals and that's that. I only use CTRL-R for
## history search since that is aready a default on many terminals. And
## some ctrl commands within a fzf window (not sure if I like that)
