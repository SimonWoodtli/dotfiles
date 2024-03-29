#!/bin/bash
##TODO make a check if insider container with hostname should start with
#workspace.xxx
sudo apk --force-refresh update && sudo apk --no-cache upgrade
## Make sure bash is default shell for current user
usermod --shell /bin/bash $USER

## Check if dotfiles are present:
if [[ ! -d "$HOME/Repos/github.com/SimonWoodtli/dotfiles" ]]; then
  folder="$HOME/Repos/github.com/SimonWoodtli/"
  mkdir -p "$folder"
  git -C "$folder" clone https://github.com/SimonWoodtli/dotfiles.git
  git -C "$folder" clone https://github.com/SimonWoodtli/zet.git
  echo "Couldn't find SimonWoodtli/dotfiles so cloned it for you.
Next Steps:
  1. chezmoi -S $HOME/Repos/github.com/SimonWoodtli/dotfiles init --apply
  2. exec bash -l
  3. just -f $HOME/Repos/github.com/SimonWoodtli/dotfiles/.justfile firstboot-workspace"
  exit 1
fi
## Install Rust: (interactive)
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-rust

## Get recipe with packages to be installed
curl -LJ https://raw.githubusercontent.com/SimonWoodtli/workspace-alpine/main/recipe.yml -o /tmp/recipe.yml

## Get zet cmd
curl -LJ -o $HOME/.local/bin/zet https://raw.githubusercontent.com/SimonWoodtli/cmd-zet/main/zet
chmod u+x $HOME/.local/bin/zet

## Install sdkman and java8:
export SDKMAN_DIR="$HOME/.config/sdkman" && curl -s "https://get.sdkman.io?rcupdate=false" | bash
source $HOME/.config/sdkman/bin/sdkman-init.sh
sdkPackages=($(yq '.sdk[]' < /tmp/recipe.yml))
for pkg in "${sdkPackages[@]}"; do
  sdk install java "$pkg"
done

## Install pipx and pips:
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipxPackages=($(yq '.pipx[]' < /tmp/recipe.yml))
for pkg in "${pipxPackages[@]}"; do
  pipx install "$pkg"
done

## Don't use install-node script, cause node is compiled with glibc and Alpine uses musl
## Install npm packages:
npmPackages=($(yq '.npm[]' < /tmp/recipe.yml))
npm install -g npm@latest
for pkg in "${npmPackages[@]}"; do
  npm install -g "$pkg"
done

## Install scripts:
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-scripts
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-ripgrepall
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-go
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-exec-oneliners
$HOME/Repos/github.com/SimonWoodtli/dotfiles/install/install-asdf

## Install go packages:
##FIXME exercism does not install
goPackages=($(yq '.go[]' < /tmp/recipe.yml))
for pkg in "${goPackages[@]}"; do
  go install "$pkg"
done

#for firsttime use of asdf
source "$HOME/.asdf/asdf.sh"
## Install asdf packages:
asdfName=($(yq '.asdf | .[].tools.name' < /tmp/recipe.yml))
asdfUrl=($(yq '.asdf | .[].tools.url' < /tmp/recipe.yml))
for x in "${!asdfName[@]}"; do
  asdfVer=($(yq ".asdf | .[$x].tools.ver | .[]" < /tmp/recipe.yml))
  asdf plugin add ${asdfName[x]} ${asdfUrl[x]}
  for y in "${!asdfVer[@]}"; do
    asdf install "${asdfName[x]}" "${asdfVer[y]}"
  done
done

## Fix bash completion for host CLI run via distrobox-host-exec:
podman cp /usr/share/bash-completion/completions/flatpak workspace:/usr/share/bash-completion/completions/flatpak
podman cp /usr/share/bash-completion/completions/podman workspace:/usr/share/bash-completion/completions/podman
podman cp /usr/share/bash-completion/completions/rpm-ostree workspace:/usr/share/bash-completion/completions/rpm-ostree
podman cp /usr/share/bash-completion/completions/mpc workspace:/usr/share/bash-completion/completions/mpc
podman cp /usr/share/bash-completion/completions/playerctl.bash workspace:/usr/share/bash-completion/completions/playerctl.bash
