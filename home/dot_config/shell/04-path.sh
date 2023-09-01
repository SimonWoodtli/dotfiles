
############################## Export PATH #############################

# be sure NOT to add ./ cuz it's unsafe
export PATH=\
$SCRIPTS:\
$SCRIPTS_PRIV:\
/usr/lib/go-1.18/bin:\
$HOME/.local/bin:\
$HOME/.local/go/bin:\
$XDG_DATA_HOME/cargo/bin:\
$HOME/.cargo/bin:\
$HOME/.local/npm/bin:\
$HOME/.deno/bin:\
$HOME/.emacs.d/bin:\
$HOME/.nix-profile/bin:\
/nix/var/nix/profiles/default/bin:\
/usr/local/opt/coreutils/libexec/gnubin:\
/usr/local/go/bin:\
/usr/local/tinygo/bin:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/games:\
/usr/sbin:\
/usr/bin:\
/snap/bin:\
/sbin:\
/bin

# be sure not to remove ./ or stuff gets weird
export CDPATH=\
./:\
$REPOS/github.com/$GITUSER:\
$REPOS/github.com/$GITUSER/dotfiles:\
$REPOS/github.com/$GITUSER/books:\
$REPOS/github.com/*:\
$REPOS/github.com:\
$REPOS:\
/media/$USER:\
$HOME
