
############################## COMPLETION ##############################
# Most completion is set near the function that uses it or internally inside
# the command itself using https://github.com/rwxrob/cmdtab for completion.

if [ -r /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

owncomp=( cry pdf yt zet sshkey gm lorem tidder snippet )
for i in "${owncomp[@]}"; do complete -C "$i" "$i"; done

## autocomplete for tldr
complete -W "$(tldr 2>/dev/null --list)" tldr

## if gh-cli auto complete should not work:
## deactivate gh completion
_have chezmoi && _source_if "$DOTFILES/completion/chezmoi.sh"
_have gh && . <(gh completion -s bash)
_have pandoc && . <(pandoc --bash-completion)
#_have spotify && . <(spotify completion bash 2>/dev/null)
#_have podman && _source_if "$HOME/.local/share/podman/completion" # d
_have docker && _source_if "$HOME/.local/share/docker/completion" # d
_have docker-compose && complete -F _docker_compose dc # dc
_have deno && source /usr/local/etc/bash_completion.d/deno.bash

# Check whether we're running a version of Bash that has support for
# programmable completion. If we do, enable all modules installed in
# the system and user profile in obsolete /etc/bash_completion.d/
# directories. Bash loads completions in all
# $XDG_DATA_DIRS/bash-completion/completions/
# on demand, so they do not need to be sourced here.
if _have nix && shopt -q progcomp &>/dev/null; then
  source "$NIX_BASH_COMPLETION/etc/profile.d/bash_completion.sh"
  nullglobStatus=$(shopt -p nullglob)
  shopt -s nullglob
  for p in $NIX_PROFILES; do
    for m in "$p/etc/bash_completion.d/"*; do
      . "$m"
    done
  done
  eval "$nullglobStatus"
  unset nullglobStatus p m
fi
