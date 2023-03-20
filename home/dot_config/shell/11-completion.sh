
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
