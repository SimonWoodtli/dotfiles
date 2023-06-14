
############################## Export PATH #############################

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# be sure NOT to add ./ cuz it's unsafe
export PATH=\
$SCRIPTS:\
$SCRIPTS_PRIV:\
/usr/lib/go-1.15/bin:\
$HOME/.local/bin:\
$HOME/.local/go/bin:\
$XDG_DATA_HOME/cargo/bin:\
$HOME/.node/bin:\
$HOME/.deno/bin:\
$HOME/.emacs.d/bin:\
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
