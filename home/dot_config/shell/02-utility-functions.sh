
########################### Utility Functions ##########################

_have()      { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }
onmac() { [ "$PLATFORM" == mac ] && return 0 || return 1; }
onwin() { [ "$PLATFORM" == windows ]  && return 0 || return 1; }
onlinux() { [ "$PLATFORM" == linux ]  && return 0 || return 1; }
onunknown() { [ "$PLATFORM" == unknown ]  && return 0 || return 1; }

if hash &>/dev/null; then
  _have() { hash "$1" &>/dev/null; }
else
	# hashing disabled (NixOS)
	has() { type "$1" &>/dev/null; }
fi
